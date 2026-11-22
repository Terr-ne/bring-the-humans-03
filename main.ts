// bring-the-humans-03 entry program (Node 22, standard library only).
//
// The entry is the TikTok video itself; this program's only job is to hand
// the video's address to the grader: it copies VIDEO.json from the
// repository root to /output/VIDEO.json, byte for byte. The house reads the
// video's counts from TikTok and writes them beside it; nothing this program
// writes about the video is scored.
//
// Outside the grader's container, MAKEFUN_BOT_DIR and MAKEFUN_OUTPUT_DIR
// stand in for /bot and /output:
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts

import { copyFileSync, mkdirSync, readFileSync } from 'node:fs';
import { join } from 'node:path';

const BOT_DIR = process.env.MAKEFUN_BOT_DIR ?? '/bot';
const OUTPUT_DIR = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';

mkdirSync(OUTPUT_DIR, { recursive: true });
const src = join(BOT_DIR, 'VIDEO.json');
const dst = join(OUTPUT_DIR, 'VIDEO.json');
try {
  copyFileSync(src, dst);
} catch (err) {
  console.error(`VIDEO.json could not be copied from ${BOT_DIR}: ${(err as Error).message}`);
  process.exit(1);
}

// Verify the hand-off before reporting success: the copy must be byte for
// byte the repository's file, and the file must parse as a JSON object with
// a string url. A silent bad copy would surface only as a refused entry, so
// fail loudly here instead. (The starter placeholder parses and copies fine;
// the gate, not this program, is what refuses a placeholder address.)
const want = readFileSync(src);
const got = readFileSync(dst);
if (!want.equals(got)) {
  console.error('VIDEO.json copy does not match the repository file byte for byte');
  process.exit(1);
}
try {
  const parsed = JSON.parse(got.toString('utf8'));
  if (typeof parsed?.url !== 'string' || parsed.url.length === 0) throw new Error('no url string');
} catch (err) {
  console.error(`VIDEO.json is not a JSON object with a url: ${(err as Error).message}`);
  process.exit(1);
}
