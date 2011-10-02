def require_if_exists(file)
  require file.gsub(".rb", "") if File.exists?("#{file}")
end

def in_home_folder(file)
  "#{ENV['HOME']}/#{file}"
end