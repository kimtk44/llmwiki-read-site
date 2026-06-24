#!/bin/bash

# Copy reading digests into ./content/
rsync -av --delete /home/taekyu/llmwiki/wiki/reading/ ./content/

# Regenerate index.md
cat << 'EOF' > ./content/index.md
---
title: Welcome to LLMWiki Reading Digests
---
# Welcome to LLMWiki Reading Digests

Here are the collected reading digests.
EOF
