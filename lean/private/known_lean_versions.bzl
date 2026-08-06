"""Hash table for known Lean 4 release tarballs.

Bumping a Lean version requires adding an entry here. To compute sha256, hash
the exact URL `_download_lean` builds — a GitHub RELEASE ASSET, which is
immutable, not a `/archive/refs/tags/` tarball, which GitHub generates on
demand and does not promise to keep byte-stable:

    curl -fsSL https://github.com/leanprover/lean4/releases/download/v<V>/<asset> \\
      | shasum -a 256

Unpinned versions can still be downloaded (unverified) — `lake_workspace`
will emit a warning. Always prefer pinning.
"""

# Map: lean version tag (with leading 'v') -> { platform -> sha256 hex }.
KNOWN_LEAN_VERSIONS = {
    "v4.29.1": {
        "darwin_aarch64": "c15284adf88ad830c71775b9828cb81f49f7f262cbe1456b25d935855bd70975",
        "linux_x86_64": "357acb30fca2212986fdc8b83dbe88e8f5610efc060f6e3515079c56a92d276f",
    },
    "v4.30.0-rc2": {
        "darwin_aarch64": "1bda6929976b2a034985fdfc85faa5e757421f6542c5e59c644e44dc1132fe51",
        "darwin_x86_64": "822b5a802763c3833c748ba6dd781fdf16426a16b7b7b2b753783ff3435feb7b",
        "linux_x86_64": "0006942b918c7fb9751a5e50b9e5ad570c5cc6aa758c980a3abc054dd8739d35",
        "linux_aarch64": "62c60766b850e1d5b4405742c4aefff097441105e51f5fb5c1bf90434b8e0960",
    },
    # All four platforms, because the point of pinning is that whichever host
    # the build lands on gets a verified download; two of four leaves the other
    # two silently unverified, which is the state this entry was added to fix.
    "v4.32.2": {
        "darwin_aarch64": "fb62ba1a932ac2266c91d0f14ab5620a7e13823a751eae79bb9a776c707a9cdc",
        "darwin_x86_64": "35c117b3eb9baf5588e6e97bd319df891b71aa6f4ba2e5bf164cd798096c82de",
        "linux_x86_64": "fb97c65730b22927951dadae964f06b2b0e6cfb2cc60f3abe26d8c99f27aa02b",
        "linux_aarch64": "593f5d95f6c37fd54e871b683d8efbb42c4224bdfe8ac0170592c30f1321798c",
    },
}

# Per-platform asset filename template. Lean release naming has shifted
# slightly across versions; this is the modern (4.20+) convention.
PLATFORM_ASSETS = {
    "darwin_aarch64": "lean-{v}-darwin_aarch64.zip",
    "darwin_x86_64": "lean-{v}-darwin.zip",
    "linux_x86_64": "lean-{v}-linux.zip",
    "linux_aarch64": "lean-{v}-linux_aarch64.zip",
}
