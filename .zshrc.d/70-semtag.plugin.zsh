# Helper function to release a tag.
if command -v git-chglog >/dev/null 2>&1 && command -v semtag >/dev/null 2>&1; then
  function git-release() {
    local next_tag=$(semtag "$@" -o)
    git-chglog -o CHANGELOG.md --next-tag "$next_tag"
    git add CHANGELOG.md
    git commit -m"chore: tag $next_tag"
    semtag "$@"
  }
fi
