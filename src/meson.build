protoc = find_program('protoc')

proto_name = 'meta'
infile_name = proto_name + '.proto'
# this kind of object keeps track of paths
infile = files(infile_name)
# this is needed becuase of protoc doens't attempt to resolve some paths.
proto_path = meson.current_source_dir()

subdir('c')
subdir('cpp')
subdir('js')
subdir('python')
