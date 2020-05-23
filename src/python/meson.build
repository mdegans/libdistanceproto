# build the Python version
pymod = import('python')

python3 = pymod.find_installation()

if python3.found()
  init_py = files('__init__.py')
  output = proto_name + '_pb2.py'
  install_dir = join_paths(python3.get_install_dir(), 'distanceproto')
  # generate and install meta_pb2.py
  libdistanceproto_py = custom_target(proto_name + '_py',
    input: infile,
    output: output,
    command: [
      protoc,
      '--proto_path', proto_path,
      '--python_out', meson.current_build_dir(),
      infile_name,
    ],
    install: true,
    install_dir: install_dir,
  )
  # install __init__.py
  install_data(init_py,
    install_dir: install_dir,
  )
  # TODO(mdegans): install target here using setuptools
endif
