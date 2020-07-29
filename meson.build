# source of truth for package info 
# (changing these changes config_meson.h and many other things)
project('distanceproto', ['cpp'],
  version: run_command(
    'head', '-n', '1', files('VERSION'),
  ).stdout().strip(),
  meson_version: '>= 0.49.0',
  license : 'LGPL',
  default_options: [
    'warning_level=2',  # -Wall
  ]
)

package_description = 'Social distancing protobuf library.'
package_version = meson.project_version()
package_author = 'Michael de Gans'
package_email = 'michael.john.degans@gmail.com'
package_uri = 'https://github.com/mdegans/libdistanceproto'

# get the cpp compiler
cc = meson.get_compiler('cpp')

# extra cflags:
add_project_arguments(
  # '-Wall',  # implied by warning_level above
  '-Wno-unused-parameter',
  '-Wshadow',
  '-Werror',
  '-fno-exceptions',
  language : 'cpp'
)

subdir('src')
