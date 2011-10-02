def require_if_exists(file)
  require file.gsub(".rb", "") if File.exists?("#{file}")
end