import pickle

import faiss

# Note for the Break milestone
# Name one way the index file and the metadata file could end up out of step, so that ID 3 returns the wrong text, with no error at all.
# Two functions write two separate files from two separate inputs, and nothing checks that they still match.
# One concrete way: you change something in data/, rebuild one file, and keep the old copy of the other.
# You'll break it deliberately in the Break milestone, so write this down.
def build_faiss_index(embeddings, save_path="faiss_index"):
    dimension = embeddings.shape[1]
    print(f"Building FAISS index with dimension: {dimension}")

    index = faiss.IndexFlatL2(dimension)
    index.add(embeddings.astype('float32'))

    faiss.write_index(index, f"{save_path}.index")
    print(f"Saved FAISS index to {save_path}.index")

    return index

# TODO - next step: # Step 4: Retrieving Relevant Information
def save_metadata(text_chunks, path="faiss_metadata.pkl"):
    with open(path, "wb") as f:
        pickle.dump(text_chunks, f)
    print(f"Saved text metadata to {path}")
