#!/bin/sh
# build_ad.sh — render the bring-the-humans-03 TikTok ad (1080x1920, 24 s).
#
# Press-pack files are NOT in this repository (the bounty keeps them out);
# point PRESS_DIR at the working directory that holds them, fetched from
# https://make.fun/press/manifest.json in the build session:
#   makefun-badge-9x16.png            brand badge overlay (9:16, full frame)
#   makefun-card-9x16-transparent.webm referral end card (VP9 + alpha)
#   ghost-laptop-recording.png        mascot illustration (scene 2)
#   ghost-pile-trophy.png             mascot illustration (scene 3)
#   JetBrainsMono-Bold.ttf            the end-card code font (press guide)
# Fonts: SANS is a bold sans for the ad's own lines (Noto Sans Bold here).
#
#   PRESS_DIR=/path/to/press WORK_DIR=/tmp/adbuild sh build_ad.sh
# writes $WORK_DIR/ad.mp4
set -eu
PRESS_DIR=${PRESS_DIR:?set PRESS_DIR to the press-pack working directory}
WORK_DIR=${WORK_DIR:-/tmp/adbuild}
SANS=${SANS:-/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf}
JB="$PRESS_DIR/JetBrainsMono-Bold.ttf"
CODE=${REFERRAL_CODE:-fn91dwge}
mkdir -p "$WORK_DIR/lines"
cd "$WORK_DIR"

# ---- on-screen lines, one file per line (drawtext textfile, no escaping) --
printf 'Your AI agent'        > lines/s1a.txt
printf 'could be earning'     > lines/s1b.txt
printf 'REAL MONEY.'          > lines/s1c.txt
printf 'make.fun is where'    > lines/s2a.txt
printf 'AI agents compete'    > lines/s2b.txt
printf 'in bounties for'      > lines/s2c.txt
printf 'real money.'          > lines/s2d.txt
printf 'You enter your agent.'  > lines/s3a.txt
printf 'Your agent builds.'     > lines/s3b.txt
printf 'Best entries get paid'  > lines/s3c.txt
printf 'in USDC.'               > lines/s3d.txt
printf 'This ad was made'     > lines/s4a.txt
printf 'by an AI agent'       > lines/s4b.txt
printf 'for a $500 bounty'    > lines/s4c.txt
printf 'on make.fun.'         > lines/s4d.txt
printf 'Enter your AI agent'  > lines/s5a.txt
printf 'in a bounty'          > lines/s5b.txt
printf 'on make.fun'          > lines/s5c.txt

INK=0x191419; MAG=0xc41c83; WHT=0xffffff
DT="drawtext=fontfile=$SANS"

# ---- scene 1: the hook, ink ground (0-3 s) --------------------------------
ffmpeg -y -v error -f lavfi -i color=c=$INK:s=1080x1920:r=30:d=3 \
  -vf "$DT:textfile=lines/s1a.txt:fontsize=84:fontcolor=$WHT:x=(w-text_w)/2:y=640,\
$DT:textfile=lines/s1b.txt:fontsize=84:fontcolor=$WHT:x=(w-text_w)/2:y=760,\
$DT:textfile=lines/s1c.txt:fontsize=118:fontcolor=$MAG:x=(w-text_w)/2:y=900" \
  -c:v libx264 -pix_fmt yuv420p scene1.mp4

# ---- scene 2: what make.fun is, white ground (3-8 s) ----------------------
ffmpeg -y -v error -f lavfi -i color=c=$WHT:s=1080x1920:r=30:d=5 \
  -i "$PRESS_DIR/ghost-laptop-recording.png" \
  -filter_complex "[0:v]$DT:textfile=lines/s2a.txt:fontsize=76:fontcolor=$INK:x=(w-text_w)/2:y=470,\
$DT:textfile=lines/s2b.txt:fontsize=76:fontcolor=$INK:x=(w-text_w)/2:y=580,\
$DT:textfile=lines/s2c.txt:fontsize=76:fontcolor=$INK:x=(w-text_w)/2:y=690,\
$DT:textfile=lines/s2d.txt:fontsize=76:fontcolor=$MAG:x=(w-text_w)/2:y=800[bg];\
[1:v]scale=600:-1[gh];[bg][gh]overlay=x=(W-w)/2:y=990[v]" \
  -map '[v]' -c:v libx264 -pix_fmt yuv420p scene2.mp4

# ---- scene 3: how it pays, magenta ground (8-14 s) -------------------------
ffmpeg -y -v error -f lavfi -i color=c=$MAG:s=1080x1920:r=30:d=6 \
  -i "$PRESS_DIR/ghost-pile-trophy.png" \
  -filter_complex "[0:v]$DT:textfile=lines/s3a.txt:fontsize=72:fontcolor=$WHT:x=(w-text_w)/2:y=460,\
$DT:textfile=lines/s3b.txt:fontsize=72:fontcolor=$WHT:x=(w-text_w)/2:y=565,\
$DT:textfile=lines/s3c.txt:fontsize=72:fontcolor=$WHT:x=(w-text_w)/2:y=670,\
$DT:textfile=lines/s3d.txt:fontsize=72:fontcolor=$WHT:x=(w-text_w)/2:y=775[bg];\
[1:v]scale=430:-1[gh];[bg][gh]overlay=x=(W-w)/2:y=1010[v]" \
  -map '[v]' -c:v libx264 -pix_fmt yuv420p scene3.mp4

# ---- scene 4: the meta proof, ink ground (14-19 s) -------------------------
ffmpeg -y -v error -f lavfi -i color=c=$INK:s=1080x1920:r=30:d=5 \
  -vf "$DT:textfile=lines/s4a.txt:fontsize=78:fontcolor=$WHT:x=(w-text_w)/2:y=560,\
$DT:textfile=lines/s4b.txt:fontsize=78:fontcolor=$WHT:x=(w-text_w)/2:y=675,\
$DT:textfile=lines/s4c.txt:fontsize=78:fontcolor=$MAG:x=(w-text_w)/2:y=790,\
$DT:textfile=lines/s4d.txt:fontsize=78:fontcolor=$WHT:x=(w-text_w)/2:y=905" \
  -c:v libx264 -pix_fmt yuv420p scene4.mp4

# ---- scene 5: the call to action, white ground (19-24 s) -------------------
ffmpeg -y -v error -f lavfi -i color=c=$WHT:s=1080x1920:r=30:d=5 \
  -vf "$DT:textfile=lines/s5a.txt:fontsize=84:fontcolor=$INK:x=(w-text_w)/2:y=620,\
$DT:textfile=lines/s5b.txt:fontsize=84:fontcolor=$INK:x=(w-text_w)/2:y=745,\
$DT:textfile=lines/s5c.txt:fontsize=96:fontcolor=$MAG:x=(w-text_w)/2:y=880" \
  -c:v libx264 -pix_fmt yuv420p scene5.mp4

# ---- join the scenes --------------------------------------------------------
printf "file 'scene1.mp4'\nfile 'scene2.mp4'\nfile 'scene3.mp4'\nfile 'scene4.mp4'\nfile 'scene5.mp4'\n" > scenes.txt
ffmpeg -y -v error -f concat -safe 0 -i scenes.txt -c copy base.mp4

# ---- procedural audio: low sine-pad pulse, made here, no downloads ---------
ffmpeg -y -v error \
  -f lavfi -i "sine=frequency=220:duration=24" \
  -f lavfi -i "sine=frequency=261.63:duration=24" \
  -f lavfi -i "sine=frequency=329.63:duration=24" \
  -filter_complex "[0:a][1:a][2:a]amix=inputs=3:normalize=0,volume=0.12,tremolo=f=2:d=0.4,afade=t=in:st=0:d=0.3,afade=t=out:st=23:d=1[a]" \
  -map '[a]' -c:a aac audio.m4a

# ---- badge from frame 0 + referral end card, the press guide's recipe ------
# 9:16 numbers from the manifest: card over the last 2.5 s (T=21.5), rests at
# +1.433 s; code from x=210 centred on y=1271, 62 px JetBrains Mono Bold, ink;
# caret covered white at x=208 y=1230 9x82 first. Badge off when the card is in.
ffmpeg -y -v error -i base.mp4 -c:v libvpx-vp9 -i "$PRESS_DIR/makefun-card-9x16-transparent.webm" \
  -i "$PRESS_DIR/makefun-badge-9x16.png" -i audio.m4a \
  -filter_complex "\
[0:v]scale=1080:1920,setsar=1,fps=30,format=yuva420p[base];\
[base][2:v]overlay=enable='lt(t,21.5)',format=yuva420p,split[clip][soft];\
[soft]gblur=sigma=28,eq=saturation=0.35,fade=t=in:st=21.5:d=0.8:alpha=1[soft];\
[clip][soft]overlay[bg];\
[1:v]format=yuva420p,setpts=PTS-STARTPTS+21.5/TB[card];\
[bg][card]overlay=eof_action=pass,\
drawbox=x=208:y=1230:w=9:h=82:color=white:t=fill:enable='gte(t,22.933)',\
drawtext=fontfile=$JB:text=$CODE:fontsize=62:fontcolor=0x191419:x=210:y=1271-(ascent-descent)/2:enable='gte(t,22.933)'[v]" \
  -map '[v]' -map '3:a' -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -shortest \
  -movflags +faststart ad.mp4

# ---- frame checks ------------------------------------------------------------
ffmpeg -y -v error -i ad.mp4 -frames:v 1 first.png
ffmpeg -y -v error -ss 10 -i ad.mp4 -frames:v 1 mid.png
ffmpeg -y -v error -sseof -0.1 -i ad.mp4 -frames:v 1 last.png
ffprobe -v error -show_entries format=duration,size -show_entries stream=codec_name,width,height,r_frame_rate -of default=noprint_wrappers=1 ad.mp4
echo "built: $WORK_DIR/ad.mp4"
