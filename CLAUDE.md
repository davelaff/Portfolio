# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is David Lafferty's personal portfolio repo. It is a loose collection of independent
artifacts, not a single application — there is no shared build system, package manager, or test
suite tying the pieces together. Treat each top-level item as its own self-contained project when
making changes.

## Structure

- **`ArtBase.sql`** — A Microsoft SQL Server (T-SQL) schema dump for a fictional art-gallery
  database, encoded as **UTF-16LE with CRLF line endings** (a `sqlcmd`/SSMS export). Do not
  read or edit it as plain UTF-8 — tools like `cat`/`grep` will show mangled spaced-out text.
  Convert first, e.g. `iconv -f UTF-16LE -t UTF-8 "ArtBase.sql"`, and convert back
  (`iconv -f UTF-8 -t UTF-16LE`) if writing changes back to preserve the original encoding.
  Tables: `Period`, `Category`, `Material`, `Movement`, `Artist`, `Subject`, `Artwork`, `Orders`,
  `PurchaseRecord`, `Guest`, plus views `Artwork_Information`, `Guest_Information`,
  `Artist_Information`. `Artwork` is the central table, foreign-keyed to `Period`, `Movement`,
  `Artist`, `Category`, `Material`, and `Subject`.
- **`ArtBase Schema.jpg`** — An entity-relationship diagram image corresponding to `ArtBase.sql`.
  Keep it in sync (regenerate/update) if the schema changes.
- **`gratitude-coach/index.html`** — A single-file, static, client-side web app (no build step,
  no dependencies, no server). Open it directly in a browser or serve statically
  (e.g. `python3 -m http.server` from `gratitude-coach/`) to run it.

## `gratitude-coach/index.html` architecture

Everything — HTML, CSS, and JS — lives in this one file. Key points for anyone editing it:

- **Direct browser calls to the Anthropic API.** The user pastes their own Anthropic API key into
  a setup screen; it's stored in `localStorage` (`gc_apikey`) and sent as the `x-api-key` header
  on `fetch('https://api.anthropic.com/v1/messages')` calls, using the
  `anthropic-dangerous-direct-browser-access: true` header (required for calling the Messages API
  from a browser instead of a backend). There is no server component and no key proxying.
- **Conversation state** (`messages`) is kept in memory only and is not persisted — a page reload
  starts a fresh conversation. **Insights** (`insights`, tagged strengths/growth-edges parsed out
  of coach replies) *are* persisted to `localStorage` (`gc_insights`) and survive reloads.
- **The coach's behavior is entirely defined by the `SYSTEM_PROMPT` constant.** It instructs the
  model to ask one question at a time and to append a machine-parsable line to its replies when it
  has an observation to record:
  `INSIGHT[positive]: <text>` or `INSIGHT[constructive]: <text>`. `handleCoachResponse()` regexes
  this line out of the reply, strips it from what's shown/spoken to the user, and records it as an
  insight card. If you change the tagging format in the prompt, update the matching regex in
  `handleCoachResponse()` (and the strip in `speak()`) to match.
- **Voice I/O** uses browser-native Web APIs only: `SpeechRecognition`/`webkitSpeechRecognition`
  for push-to-talk input and `speechSynthesis` for text-to-speech output — no external speech
  services. Both degrade gracefully (mic button disables, TTS toggle is skippable) when the APIs
  aren't available.
- There is no test setup, linter, or bundler for this file — verify changes by opening
  `index.html` in a browser (a real Anthropic API key is required to exercise the chat flow; the
  UI shell can be inspected without one).
