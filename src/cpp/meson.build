# build the pp version
libprotobuf = dependency('protobuf')

output = [proto_name + '.pb.cc', proto_name + '.pb.h']

# there is probably an easier way to do this, but this works.
libdistanceproto = custom_target(proto_name,
  output: output,
  command: [
    protoc,
    '--proto_path', proto_path,
    '--cpp_out', meson.current_build_dir(),
    infile_name,
  ],
  install_dir: meson.project_name(),
  install: true,
)

# this doesn't work so not sure how to fix it for now you can find the header
# in the build dir
# header = join_paths(meson.current_build_dir(), output[1])
# install_headers(
#   header,
#   subdir: meson.project_name(),
# )

libdistanceproto_lib = library(meson.project_name(), libdistanceproto,
  version: meson.project_version(),
  dependencies: libprotobuf,
  install: true,
)

pkg_mod = import('pkgconfig')
pkg_mod.generate(
  description: 'libdistanceproto - cpp version',
  libraries: libdistanceproto_lib,
  version: meson.project_version(),
  name: meson.project_name(),
)
