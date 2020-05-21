# build the Python version
# supported_python_versions = ['2.7', '3.6', '3.7', '3.8', '3.9']
supported_python_versions = ['3.6', '3.8']

init_py = files('__init__.py')

build_for_versions = []
foreach ver : supported_python_versions
  py_exe_name = 'python' + ver
  if find_program(py_exe_name, required: false).found()
    build_for_versions += py_exe_name
  endif
endforeach

foreach ver : build_for_versions
  output = proto_name + '_pb2.py'
  package_path = join_paths(
    get_option('prefix'),
    'lib',
    ver,
    'site-packages',
    meson.project_name(),
  )
  # generate and install meta_pb2.py
  libdistanceproto_py = custom_target(proto_name + 'py' + ver,
    input: infile,
    output: output,
    command: [
      protoc,
      '--proto_path', proto_path,
      '--python_out', meson.current_build_dir(),
      infile_name,
    ],
    install: true,
    install_dir: package_path,
  )
  # install __init__.py
  install_data(init_py,
    install_dir: package_path,
  )
  # TODO(mdegans): install target here using setuptools
endforeach
