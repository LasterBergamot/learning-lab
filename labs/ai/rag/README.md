# RAG

**Status:** building · **Tier:** T0 · **Tested on:** Linux/Docker ⬜ Windows/Podman ⬜

> Track: [`ai`](../README.md) · Level: `level:3-build` · Cost: RAM ~2 GB, disk ~6 GB (mostly PyTorch), trial: none

<!--
Status values: todo | learning | building | done (see docs/How-I-Learn.md, "Lab milestones").
Tick a "Tested on" box (⬜ → ✅) only after a real run on that platform.
Keep the Status line exactly in this shape: CI and roadmap-sync read it.
-->

## Goal

Build a small retrieval-augmented generation pipeline from scratch, step by step: load and clean
documents, split them into chunks, embed the chunks, store them in a FAISS index, retrieve the
chunks that match a question, and have an LLM answer from them. Then explain where each step
can go wrong.

**Why it lasts:** Models change every few months, but the idea underneath stays: a model only
knows what is in its weights and its prompt, so you fetch the relevant facts at question time
and put them in front of it. Chunking, embeddings, nearest-neighbour search and grounding are
information-retrieval ideas that predate LLMs and will outlive today's tools.

## Prerequisites

- Prompt engineering (`prompt-engineering` in the [AI track](../README.md)): the last step is
  a prompt that has to keep the model on the retrieved text
- Embeddings and vector search (`vector-search` in the [AI track](../README.md)): steps 3–4
  of the pipeline are exactly this
- Gap: neither lab exists yet. Covering embeddings and similarity search inside this lab is fine;
  note what was skipped in `NOTES.md`.

## Key concepts

- Chunking (size, overlap): <one line, filled in by you after the lab>
- Sentence embeddings: <…>
- Exact vs. approximate nearest-neighbour search: <…>
- Distance metrics (L2, inner product, cosine): <…>
- Grounding and hallucination: <…>

## Guiding questions

Answer these in `NOTES.md` in your own words. Write a guess before looking anything up.

1. What problem does retrieval solve that a longer prompt or fine-tuning doesn't?
2. Why split documents into chunks at all, and what do chunk size and overlap trade off?
3. What is a sentence embedding, and why must the same model embed both the chunks and the
   question?
4. `IndexFlatL2` searches exactly by L2 distance. When is inner product or cosine similarity
   the better fit, and what does vector normalisation have to do with it?
5. At what corpus size does exact search stop being good enough, and what do approximate
   indexes (IVF, HNSW) give up in return?
6. How do you pick *k*, the number of chunks to retrieve? What happens to the answer when the
   wrong chunks come back?
7. How do you put the retrieved chunks into the prompt so the model answers from them, and
   says so when they don't contain the answer?
8. How would you measure whether the system is any good? (This leads into the `evals` lab.)

## Milestones

- [ ] **Understand:** explain the pipeline (load → clean → chunk → embed → index → retrieve →
  generate) without notes, and what each step's output looks like
- [ ] **Build:** the whole pipeline runs from one entry point over `data/` and answers a
  question from the retrieved chunks, showing which chunks it used
- [ ] **Break:** ask something the corpus doesn't cover; then make the question embedding no
  longer match the index (another model, or an index built from stale chunks)
- [ ] **Fix:** the system says when it can't answer from its sources, and the index is rebuilt
  consistently: this proves you understand the contract between indexing and querying
- [ ] **Explain:** write the summary in `NOTES.md` and add recall questions to [the review queue](../../../docs/Review-Queue.md)

## Isolation and platforms

- **Tier:** T0, a `uv` virtual environment in this folder, Python pinned by `.python-version`
  (see [Isolation](../../../docs/Isolation.md))
- **Compose project name / cluster name:** none (no containers). If the generation step later
  runs a local model in a container, use `ai-rag`.
- **Run from this folder** (`labs/ai/rag/`): `uv sync` creates `.venv/`, and the default data
  path `data/` is relative to the working directory.
- **The embedding model** (`all-MiniLM-L6-v2`, ~90 MB) is downloaded on first use into the
  Hugging Face cache, outside the repo.
- **Omarchy (Linux/Docker):** the default PyTorch wheel from PyPI on Linux pulls the CUDA
  libraries too (the venv is ~5–6 GB) even though the VM has no GPU. The VM is short on disk:
  uv's PyTorch guide (References) explains how to use the CPU-only wheels. Cache:
  `~/.cache/huggingface/`.
- **Windows 11 (Git Bash/Podman):** `uv sync` in Git Bash; the PyPI PyTorch and `faiss-cpu`
  wheels for Windows are CPU-only, so the venv is smaller. Cache:
  `%USERPROFILE%\.cache\huggingface\`. Without Developer Mode, `huggingface_hub` warns that it
  can't use symlinks in the cache; it still works, but uses more disk.
- **Generation step:** a local model (for example through Ollama) keeps the lab T0 and free,
  within the VM's 13 GB RAM and no GPU. A hosted API needs a key: keep it in `.env`
  (git-ignored), never in the code.

Both platforms are kept in sync: a change to one section updates the other in the same commit
(see [Platforms](../../../docs/Platforms.md)).

## Teardown

See `TEARDOWN.md`. Nothing runs in the background in this lab, so teardown is about disk.

## References

Every online source used for this lab, one line each, official sources first:

- [FAISS documentation](https://faiss.ai/) — the index types, metrics and API used for steps 3–4
- [FAISS wiki](https://github.com/facebookresearch/faiss/wiki) — choosing an index, and the trade-offs of exact and approximate search
- [Sentence Transformers documentation](https://sbert.net/) — how the embedding model is loaded and used
- [all-MiniLM-L6-v2 model card](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) — the embedding model: dimension, input limit, intended use
- [langchain-text-splitters on PyPI](https://pypi.org/project/langchain-text-splitters/) — the recursive character splitter used for chunking
- [uv: using uv with PyTorch](https://docs.astral.sh/uv/guides/integration/pytorch/) — CPU-only PyTorch wheels, to keep the venv small on Linux
- [Lewis et al., Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks (2020)](https://arxiv.org/abs/2005.11401) — the paper that named RAG
- [7 Steps to Build a Simple RAG System from Scratch (KDnuggets)](https://www.kdnuggets.com/7-steps-to-build-a-simple-rag-system-from-scratch) — the walkthrough this lab follows
