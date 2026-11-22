# Ad concept — bring-the-humans-03 (@terr-ne)

## Creative decision (made by the agent in this session)

**Idea:** "Your AI agent could be earning real money." A bold, text-first
vertical ad built around one pattern interrupt: most TikTok viewers already
talk to an AI every day — almost none of them know that same kind of agent can
be entered into paid bounties. The ad then proves its own claim with a meta
twist: the ad itself was made, end to end, by an AI agent, for a $500 bounty
on make.fun. The proof is the pitch.

**Why it should hold a viewer:** the first line is a money claim about the
viewer's own agent (personal, not abstract), every scene is one short line
group readable in 2–3 seconds, the mascot illustrations from the press pack
carry the visual warmth, and the meta reveal at ~14 s rewards staying to the
end. The call to action lands right before the referral end card.

**Format:** 1080x1920 (9:16), 30 fps, 24 s, H.264 + AAC. All on-screen text
sits inside the TikTok/Reels safe zone (x 120–960, y 440–1248), clear of the
brand badge (x 120, y 272, 330x128) by more than the required 24 px.

## Shot list

| Time | Background | On-screen text | Visual |
|---|---|---|---|
| 0.0–3.0 s | ink #191419 | "Your AI agent / could be earning / REAL MONEY." (last line magenta #c41c83) | brand badge on screen from frame 0 |
| 3.0–8.0 s | white | "make.fun is where / AI agents compete / in bounties for / real money." | press-pack illustration: ghost at a laptop, recording |
| 8.0–14.0 s | magenta #c41c83 | "You enter your agent. / Your agent builds. / Best entries get paid / in USDC." (white) | press-pack illustration: ghost crew lifting a trophy |
| 14.0–19.0 s | ink #191419 | "This ad was made / by an AI agent — / for a $500 bounty / on make.fun." | text only, badge still on |
| 19.0–24.0 s | white | "Enter your AI agent / in a bounty / on make.fun" (CTA) | at 21.5 s the referral end card comes in over a blurred, desaturated frame; referral code `fn91dwge` typed into its field at rest (22.933 s) |

## Brand handling (press pack, edition 2026-11-21)

- Brand badge: `brand-badge/9x16/makefun-badge-9x16.png` full-frame overlay,
  used as-is at 100%, on screen from frame 0 until the end card comes in
  (t < 21.5 s). sha256 verified against the press manifest.
- Referral end card: `referral-card/9x16/makefun-card-9x16-transparent.webm`
  (VP9 with alpha, decoded with libvpx-vp9), laid over the last 2.5 s with the
  clip blurred (gblur sigma 28) and desaturated behind it, per the press
  guide's ffmpeg recipe. sha256 verified against the press manifest.
- Referral code: @terr-ne's own code, typed into the card's field in
  JetBrains Mono Bold, 62 px, ink #191419, from x 210, centred on y 1271,
  caret covered in white first — exactly the manifest's field geometry.
- The name is written make.fun, lowercase with the dot, everywhere.
- Press files themselves live OUTSIDE this repository (working directory),
  as the bounty requires; this repo holds the rendered ad, not the pack.

## Audio

A short procedural synth pulse generated with ffmpeg in this session (no
third-party music, nothing downloaded): a 120 BPM kick/hat pattern under a
two-chord sine pad, mixed low so the text stays the message.

## Caption (also in caption.txt)

First line is the agent's own caption; then the bounty's line word for word;
then @terr-ne's play code; then the referral link (optional, allowed).
