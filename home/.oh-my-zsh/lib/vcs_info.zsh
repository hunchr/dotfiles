# Don't skip this file until a Zsh release does the necessary quoting.
autoload -Uz +X regexp-replace VCS_INFO_formats 2>/dev/null || return 0

# We use $tmp here because it's already a local variable in VCS_INFO_formats
typeset PATCH='for tmp (base base-name branch misc revision subdir) hook_com[$tmp]="${hook_com[$tmp]//\%/%%}"'
# Unique string to avoid reapplying the patch if this code gets called twice
typeset PATCH_ID=vcs_info-patch-9b9840f2-91e5-4471-af84-9e9a0dc68c1b

# Only patch the VCS_INFO_formats function if not already patched
if [[ "$functions[VCS_INFO_formats]" != *$PATCH_ID* ]]; then
  regexp-replace 'functions[VCS_INFO_formats]' \
    "VCS_INFO_hook 'post-backend'" ': ${PATCH_ID}; ${PATCH}; ${MATCH}'
fi

unset PATCH PATCH_ID
