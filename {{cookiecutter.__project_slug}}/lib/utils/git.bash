#!/usr/bin/env bash
#
# Lib dependencies:
# - common

#####
## FUNCTIONS
###

# Fetch or update Git repository given in parameter '1', with branch as
# parameter 2 and target directory as parameter 3.
# 1: repository URL to fetch (or update if exist)
# 2: branch to fetch
# 3: directory where files would be copied
git_clone() {
  address="${1}"
  branch="${2}"
  target="${3}"

  # If target directory existe, we just update the repository.
  if [[ -d "${target}" ]]; then
    info_msg "Git: updating regarding ${target} repository"
    cd "${target}" && git pull -q && cd - &>/dev/null \
      && success_msg "Successful update!"
  else
    info_msg "Git: Cloning from '${address}' (branch: ${branch}) to ${target}"
    git clone -q --branch="${branch}" "${address}" "${target}" \
      && success_msg "Clone: successful!" \
      || err_msg_and_exit "failed to clone '${address}' (branch: ${branch})"
  fi
}

# vim: ts=2 sw=2 et nu syn=bash
