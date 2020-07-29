protobuf = dependency('protobuf', version: '>=3.0.0')
protoc = find_program('protoc')

# many thanks to @marcelhollerbach for his solution.
# https://github.com/mesonbuild/meson/issues/7511#issuecomment-665470520

distance_pb_cc = custom_target('distance_pb_cc',
  input: ['distance.proto'],
  output: ['@BASENAME@.pb.cc'],
  command: [
    protoc,
    '--proto_path=@CURRENT_SOURCE_DIR@',
    '--cpp_out=@OUTDIR@',
    '@INPUT@',
  ]
)

distance_pb_h = custom_target('distance_pb_h',
  input: ['distance.proto'],
  output: ['@BASENAME@.pb.h'],
  command: [
    protoc,
    '--proto_path=@CURRENT_SOURCE_DIR@',
    '--cpp_out=@OUTDIR@',
    '@INPUT@',
  ],
  install: true,
  install_dir: get_option('includedir'),
)

libdistanceproto = library(meson.project_name(), distance_pb_cc,
  version: meson.project_version(),
  dependencies: [protobuf],
  install: true,
)

distanceproto_dep = declare_dependency(
  link_with: libdistanceproto,
  include_directories: [include_directories('.')],
  dependencies: protobuf,
)

pkg = import('pkgconfig')
distanceproto_pc = pkg.generate(libdistanceproto,
  description: package_description,
  url: package_uri,
  # for consistency with existing cmake install:
  install_dir: get_option('datadir') / 'pkgconfig'
)