/**
 * Claude usage footer status
 *
 * When the active model's provider is "claude-code" (from pi-claude-code), adds Claude
 * subscription usage limits to the built-in footer's extension status line:
 *
 *   C12% ↻14:30 W37%   (C = current 5-hour session window, ↻ = its local reset time,
 *                       W = 7-day weekly window)
 *
 * The built-in footer is left untouched; this only uses ctx.ui.setStatus().
 *
 * Data source: pi-claude-code attaches a `claude-code.rate-limit` diagnostic to every
 * assistant message, containing `unifiedWindows.five_hour` / `seven_day` utilization (0..1).
 *
 * Limits are account-wide, so the last known values are cached in
 * <agentDir>/claude-usage-cache.json and shown in new sessions before the first reply.
 *
 * For any other provider (or without pi-claude-code installed) the status is cleared.
 */

import { readFileSync, renameSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { type ExtensionAPI, type ExtensionContext, getAgentDir } from "@earendil-works/pi-coding-agent";

const PROVIDER = "claude-code";
const DIAGNOSTIC = "claude-code.rate-limit";
const STATUS_KEY = "claude-usage";

interface Window {
	utilization?: number;
	resetsAt?: number; // unix seconds
}
interface Limits {
	session?: Window;
	week?: Window;
}

function extractLimits(message: any): Limits | undefined {
	if (message?.role !== "assistant" || message.provider !== PROVIDER || !Array.isArray(message.diagnostics)) {
		return undefined;
	}
	for (let i = message.diagnostics.length - 1; i >= 0; i--) {
		const d = message.diagnostics[i];
		const w = d?.type === DIAGNOSTIC ? d.details?.unifiedWindows : undefined;
		if (w && typeof w === "object") return { session: w.five_hour, week: w.seven_day };
	}
	return undefined;
}

interface Cached extends Limits {
	updatedAt: number; // ms
}

function cachePath(): string {
	return join(getAgentDir(), "claude-usage-cache.json");
}

function loadCache(): Cached | undefined {
	try {
		const data = JSON.parse(readFileSync(cachePath(), "utf8"));
		return typeof data?.updatedAt === "number" ? data : undefined;
	} catch {
		return undefined;
	}
}

function saveCache(data: Cached): void {
	try {
		const path = cachePath();
		const tmp = `${path}.${process.pid}.tmp`;
		writeFileSync(tmp, JSON.stringify(data));
		renameSync(tmp, path); // atomic, safe with several pi instances
	} catch {
		// Cache is best-effort.
	}
}

export default function (pi: ExtensionAPI) {
	let limits: Cached | undefined;
	let timer: ReturnType<typeof setInterval> | undefined;

	/** Keep whichever observation is newest. */
	function accept(found: Limits, at: number, persist: boolean) {
		if (limits && limits.updatedAt >= at) return;
		limits = { ...found, updatedAt: at };
		if (persist) saveCache(limits);
	}

	function loadInitial(ctx: ExtensionContext) {
		const cached = loadCache();
		if (cached) accept(cached, cached.updatedAt, false);
		const entries = ctx.sessionManager.getEntries();
		for (let i = entries.length - 1; i >= 0; i--) {
			const e = entries[i];
			if (e.type !== "message") continue;
			const found = extractLimits(e.message);
			if (found) {
				const at = typeof (e.message as any).timestamp === "number" ? (e.message as any).timestamp : 0;
				accept(found, at, true);
				return;
			}
		}
	}

	function update(ctx: ExtensionContext) {
		if (!ctx.hasUI) return;
		if (ctx.model?.provider !== PROVIDER) {
			ctx.ui.setStatus(STATUS_KEY, undefined);
			return;
		}
		const theme = ctx.ui.theme;
		const pct = (w: Window | undefined, label: string) => {
			if (!w || typeof w.utilization !== "number") return theme.fg("dim", `${label}?%`);
			// Window already reset since we last heard from Claude Code: usage is 0 now.
			const expired = typeof w.resetsAt === "number" && w.resetsAt * 1000 <= Date.now();
			const value = expired ? 0 : Math.round(w.utilization * 100);
			const text = `${label}${value}%`;
			if (value >= 90) return theme.fg("error", text);
			if (value >= 70) return theme.fg("warning", text);
			return theme.fg("dim", text);
		};
		// Next reset of the current (5-hour) window; hidden once it has passed, since the
		// next window's reset time is unknown until Claude Code reports it.
		const reset = (w: Window | undefined) => {
			if (!w || typeof w.resetsAt !== "number") return "";
			const at = new Date(w.resetsAt * 1000);
			if (at.getTime() <= Date.now()) return "";
			const hh = String(at.getHours()).padStart(2, "0");
			const mm = String(at.getMinutes()).padStart(2, "0");
			return " " + theme.fg("dim", `↻${hh}:${mm}`);
		};
		const session = pct(limits?.session, "C") + reset(limits?.session);
		ctx.ui.setStatus(STATUS_KEY, `${session} ${pct(limits?.week, "W")}`);
	}

	pi.on("session_start", async (_event, ctx) => {
		loadInitial(ctx);
		update(ctx);
		// Re-check once a minute so a window that resets while idle drops to 0%.
		if (timer) clearInterval(timer);
		timer = setInterval(() => {
			try {
				update(ctx);
			} catch {
				// ctx may be stale after a session switch; the next session_start rebinds it.
			}
		}, 60_000);
		timer.unref?.();
	});

	pi.on("session_shutdown", async () => {
		if (timer) clearInterval(timer);
		timer = undefined;
	});

	pi.on("model_select", async (_event, ctx) => update(ctx));

	pi.on("message_end", async (event, ctx) => {
		const found = extractLimits(event.message);
		if (found) accept(found, Date.now(), true);
		update(ctx);
	});
}
