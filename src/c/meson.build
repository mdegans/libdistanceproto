# build the C version
protoc_c = find_program('protoc-c')
libprotobuf_c = dependency('libprotobuf-c')

output = [proto_name + '.pb-c.c', proto_name + '.pb-c.h']

# there is probably an easier way to do this, but this works.
libdistanceproto_c = custom_target(proto_name,
  output: output,
  command: [
    protoc_c,
    '--proto_path', proto_path,
    '--c_out', meson.current_build_dir(),
    infile_name,
  ],
  install_dir: [false, get_option('includedir')],
  install: true,
)

libdistanceproto_c_lib = library(meson.project_name() + '-c', libdistanceproto_c,
  version: meson.project_version(),
  dependencies: libprotobuf_c,
  install: true,
)

pkg_mod = import('pkgconfig')
pkg_mod.generate(
  description: 'libdistanceproto - C version',
  libraries: libdistanceproto_c_lib,
  version: meson.project_version(),
  name: meson.project_name() + '-c',
)
