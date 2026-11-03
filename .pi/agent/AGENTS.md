## Agent workflow

**Main agent only.** If you are a subagent, ignore this section and follow the task you were given.

Lookups: For narrow searches ("where is X defined", "who calls Y") run one-shot grep/find yourself. Use the `scout` subagent when a lookup needs several searches or would return a lot of output. In its task, say what you are looking for and why you need it. Treat any claim that something is unused or absent as unverified until you check it yourself.

You are the only agent that edits files. Subagents read and advise; they never write.

When you change files, verify the change (run it, or its tests if any) and re-read your diff. Then summarize changed files, how you validated them, and remaining notes.

Verification must be non-destructive. Work on copies or in a temporary directory, never on real user data. Do not delete or overwrite files you did not create, change system or global configuration, install or remove packages, push, deploy, or call external services with side effects. Clean up any temporary files you create. If the only way to verify is risky, stop and ask me first.

Never emit shell commands over ~100 chars; use \ line continuations or a script file.

If the same error or test failure survives two fix attempts, stop and tell me unless the request says otherwise; I may raise the thinking level before you continue.
