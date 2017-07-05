Facter.add(:composerversion_installed) do
  setcode do
    kernel = Facter.value(:kernel)
    case kernel
    when 'Linux'
      output = Facter::Util::Resolution.exec('composer -V')

      unless output.nil?
        output.split(' ').
          select { |x| x =~ %r{^(?:(\d+)\.)(?:(\d+)\.)?(\*|\d+)} }.first
      end
    end
  end
end

Facter.add(:composerversion_latest) do
  setcode do
    kernel = Facter.value(:kernel)
    case kernel
    when 'Linux'
      raw = Facter::Util::Resolution.exec('curl -s \'https://api.github.com/repos/composer/composer/releases/latest\'')

      unless raw.nil?
        parsed = JSON.parse(raw)
        parsed['name']
      end
    end
  end
end
