# Change this if you want to use a different folder name or if you have renamed the folder
# quartz-folder-name := 'quartz'
# quartz-path := path_exists(clean(join(justfile_directory(), '..', quartz-folder-name, 'quartz', 'styles')))

quartz-folder-name := '.'
# quartz-path := true
quartz-path := path_exists(clean(join(justfile_directory(), quartz-folder-name, 'styles')))

error-quartz-not-found := 'Quartz not found. Please make sure you are in the right folder or set the correct folder name in the justfile'
test-theme-path := ''

# set quietla -la

set quiet

[doc('List all available commands'), private]
default:
  @just --list

[private]
alias c := check
[private]
alias t := theme
[private]
alias u := update

[doc('Update themes')]
update:
  git pull

[doc('Check for updates')]
check:
  git fetch
  git status

# [doc('Set theme')]

theme +name:
  #!/usr/bin/env sh
  echo "Checking path: {{quartz-path}}"
  if ! '{{quartz-path}}'; then
    echo '{{error-quartz-not-found}}'
    exit 1
  fi
  echo 'Setting theme "{{name}}"'
  npm run --silent theme -- "{{replace(trim(lowercase(name)), ' ', '-')}}" || echo "Error: NPM script failed"
