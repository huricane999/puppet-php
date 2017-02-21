Facter.add(:phpextinifiles) do
  setcode do
    output = Facter::Util::Resolution.exec('php -r "echo str_replace(\',\', \'\', php_ini_scanned_files());"')
    files = {}

    unless output.nil?
      output.split("\n").each do |file|
        extension = file.scan(/^[0-9-]*(.+)\.ini/).last.first
        unless extension.nill?
          files[extension] = file
        end
      end
    end

    files
  end
end
