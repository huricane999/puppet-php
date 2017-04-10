
Facter.add(:phpinifiles) do
  setcode do
    output = Facter::Util::Resolution.exec('repoquery -l php\* | grep -e ^/etc/php.d/.*\.ini | sort')
    stringifyfacts = Facter::Util::Resolution.exec('puppet config print stringify_facts')
    files = {}

    unless output.nil?
      output.split("\n").each do |file|
        extension = file.scan(/^.*\/(?:[0-9]*-)?(.+)\.ini/).last.first
        unless extension.nil?
          if !files.key?(extension)          
            files[extension] = file
          end
        end
      end
    end

    if stringifyfacts.to_s == 'true'
      require 'json'
      files.to_json
    else
      files
    end
  end
end
