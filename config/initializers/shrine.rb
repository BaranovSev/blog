require "shrine"
require "shrine/storage/file_system"
 
Shrine.storages = { 
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary 
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent 
}
 
Shrine.plugin :activerecord # or :activerecord 
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays 
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file 
Shrine.plugin :validation_helpers
Shrine.plugin :validation
Shrine.plugin :derivatives # File processing / changing size of pictures 