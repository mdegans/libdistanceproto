# build the js version
output = ['person.js', 'bbox.js', 'frame.js']

# there is probably an easier way to do this, but this works.
libdistanceproto_py = custom_target(proto_name,
  input: infile,
  output: output,
  command: [
    protoc,
    '--proto_path', proto_path,
    '--js_out', meson.current_build_dir(),
    infile_name,
  ],
  install_dir: join_paths(get_option('datadir'), meson.project_name(), 'js'),
  install: true,
)

# TODO(mdegans) i have no clue about javascript. may somebody more knowledgable
# make the boilerplate for an npm package
