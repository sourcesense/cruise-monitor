def require_if_exists(file)
  require file if File.exists?("#{file}.rb")
end