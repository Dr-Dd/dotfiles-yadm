/**
 * Global AGENTS.md fallback
 *
 * The global ~/.pi/agent/AGENTS.md is used only when the current project has no
 * context file of its own (AGENTS.override.md, AGENTS.md, AGENTS.MD, CLAUDE.md, CLAUDE.MD).
 *
 * "Current project":
 *   - inside a git repo: any directory from the cwd up to the repo root (inclusive)
 *   - outside a git repo: the cwd only
 * Context files above the repo root (e.g. ~/AGENTS.md) never suppress the global file.
 *
 */
import { existsSync, realpathSync, statSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join, resolve } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const NAMES = ["AGENTS.override.md", "AGENTS.md", "AGENTS.MD", "CLAUDE.md", "CLAUDE.MD"];

function real(p: string): string {
	try {
		return realpathSync(p);
	} catch {
		return resolve(p);
	}
}

function globalDir(): string {
	return real(process.env.PI_CODING_AGENT_DIR ?? join(homedir(), ".pi/agent"));
}

function hasContextFile(dir: string): boolean {
	return NAMES.some((n) => {
		const p = join(dir, n);
		try {
			return existsSync(p) && statSync(p).isFile();
		} catch {
			return false;
		}
	});
}

/** Nearest ancestor containing `.git` (directory, or file for worktrees/submodules). */
function findGitRoot(start: string): string | undefined {
	let dir = start;
	while (true) {
		if (existsSync(join(dir, ".git"))) return dir;
		const parent = dirname(dir);
		if (parent === dir) return undefined;
		dir = parent;
	}
}

/** Directories that count as "the project": cwd .. git root, or just cwd outside git. */
function projectDirs(cwd: string): string[] {
	const root = findGitRoot(cwd);
	if (!root) return [cwd];
	const dirs: string[] = [];
	let dir = cwd;
	while (true) {
		dirs.push(dir);
		if (dir === root) break;
		const parent = dirname(dir);
		if (parent === dir) break;
		dir = parent;
	}
	return dirs;
}

function hasProjectContext(cwd: string): boolean {
	const gDir = globalDir();
	const c = real(cwd);
	if (c === gDir) return false;
	return projectDirs(c).some((d) => d !== gDir && hasContextFile(d));
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		const project = hasProjectContext(ctx.cwd ?? process.cwd());
		if (project && ctx?.hasUI) {
			const globalFile = join(globalDir(), "AGENTS.md");
			ctx.ui.notify(
				`Global ${globalFile} is listed above but will NOT be sent to the model (project context file found).`,
				"warning",
			);
		}
	});

	pi.on("before_agent_start", (event, ctx) => {
		const opts = event.systemPromptOptions;
		const project = hasProjectContext(opts.cwd);
		if (project) {
			const gDir = globalDir();
			opts.contextFiles = opts.contextFiles.filter((f) => real(dirname(f.path)) !== gDir);
		}
	});
}
