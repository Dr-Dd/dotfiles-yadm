/**
 * Minimal footer: replaces pi's built-in footer with a single line.
 *
 *   ~/path (branch)  12%/200k                    <extension statuses>  provider/model • thinking
 *
 * Extension statuses (ctx.ui.setStatus, e.g. claude-usage-footer's "C12% W37%") are kept.
 * `/minfooter` toggles back to the built-in footer.
 */

import { isAbsolute, relative, resolve, sep } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

function formatTokens(n: number): string {
	if (n < 1000) return `${n}`;
	if (n < 1_000_000) return `${Math.round(n / 1000)}k`;
	return `${(n / 1_000_000).toFixed(n < 10_000_000 ? 1 : 0)}M`;
}

function homeRelative(cwd: string): string {
	const home = process.env.HOME;
	if (!home) return cwd;
	const rel = relative(resolve(home), resolve(cwd));
	if (rel === "") return "~";
	if (rel === ".." || rel.startsWith(`..${sep}`) || isAbsolute(rel)) return cwd;
	return `~${sep}${rel}`;
}

/** Emacs/doom-modeline style: ~/code/work/my-project -> ~/c/w/my-project (dot dirs keep the dot: .config -> .c). */
function formatCwd(cwd: string): string {
	const parts = homeRelative(cwd).split(sep);
	return parts
		.map((p, i) => {
			if (i === parts.length - 1 || p === "~" || p === "") return p;
			const chars = [...p]; // code points, so non-ASCII names aren't split mid-character
			return chars.slice(0, p.startsWith(".") ? 2 : 1).join("");
		})
		.join(sep);
}

export default function (pi: ExtensionAPI) {
	let enabled = true;

	function install(ctx: ExtensionContext) {
		if (!ctx.hasUI) return;
		if (!enabled) {
			ctx.ui.setFooter(undefined);
			return;
		}
		ctx.ui.setFooter((tui, theme, footerData) => ({
			dispose: footerData.onBranchChange(() => tui.requestRender()),
			invalidate() {},
			render(width: number): string[] {
				const dim = (s: string) => theme.fg("dim", s);

				// Left: path (branch) + context usage
				const usage = ctx.getContextUsage();
				const window = usage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
				const pct = usage?.percent;
				const ctxText = `${pct == null ? "?" : `${Math.round(pct)}%`}/${formatTokens(window)}`;
				const ctxColored =
					pct != null && pct > 90 ? theme.fg("error", ctxText) : pct != null && pct > 70 ? theme.fg("warning", ctxText) : dim(ctxText);
				const branch = footerData.getGitBranch();
				const location = formatCwd(ctx.cwd) + (branch ? ` (${branch})` : "");
				const left = `${dim(location)}  ${ctxColored}`;

				// Right: extension statuses + provider/model • thinking
				const statuses = [...footerData.getExtensionStatuses().entries()]
					.sort(([a], [b]) => a.localeCompare(b))
					.map(([, t]) => t.replace(/[\r\n\t]+/g, " ").trim())
					.filter(Boolean)
					.join(" ");
				const model = ctx.model ? `${ctx.model.provider}/${ctx.model.id}` : "no-model";
				const thinking = ctx.model?.reasoning ? ` • ${pi.getThinkingLevel()}` : "";
				const modelText = dim(model + thinking);
				const right = statuses ? `${statuses}  ${modelText}` : modelText;

				const gap = width - visibleWidth(left) - visibleWidth(right);
				if (gap >= 2) return [left + " ".repeat(gap) + right];
				// Too narrow: keep the left side, truncate the rest.
				return [truncateToWidth(`${left}  ${right}`, width, dim("…"))];
			},
		}));
	}

	pi.on("session_start", async (_event, ctx) => install(ctx));

	pi.registerCommand("minfooter", {
		description: "Toggle minimal footer / built-in footer",
		handler: async (_args, ctx) => {
			enabled = !enabled;
			install(ctx);
			ctx.ui.notify(enabled ? "Minimal footer enabled" : "Built-in footer restored", "info");
		},
	});
}
