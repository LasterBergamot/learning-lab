# Teardown: RAG

This lab starts no containers, clusters or cloud resources. Teardown is about disk: the venv,
the downloaded model and the index files the pipeline writes.

## Before you start the lab

- Note the free disk space (`df -h ~` on Omarchy; on Windows, the drive in File Explorer). The
  venv is the big item, ~5–6 GB on Linux with the default PyTorch wheel.

## Remove

- [ ] The virtual environment: `.venv/` in this folder (`uv sync` recreates it from `uv.lock`)
- [ ] Files the pipeline writes into the working directory: the FAISS index (`*.index`) and the
  pickled chunk metadata (`*.pkl`). They are not git-ignored, so delete them or keep them out of
  commits.
- [ ] The embedding model in the Hugging Face cache, if disk is tight: the
  `models--sentence-transformers--all-MiniLM-L6-v2` folder under `~/.cache/huggingface/hub/`
  (Omarchy) or `%USERPROFILE%\.cache\huggingface\hub\` (Windows)
- [ ] Optional: uv's package cache, with `uv cache prune` (both platforms)
- [ ] If the generation step used a local model through Ollama: the pulled model (`ollama rm`)

## Check

- [ ] `git status` shows no index or metadata files to commit
- [ ] Free disk is back to the baseline
