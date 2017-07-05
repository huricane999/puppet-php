Facter.add(:composerversion_installed) do
  setcode do
    output = Facter::Util::Resolution.exec('composer -V')

    unless output.nil?
      output.split("\n").first.split(' ').
        select { |x| x =~ %r{^(?:(\d+)\.)(?:(\d+)\.)?(\*|\d+)} }.first
    end
  end
end

Facter.add(:composerversion_latest) do
  setcode do
    raw = Facter::Util::Resolution.exec('curl -s \'https://api.github.com/repos/composer/composer/releases/latest\'')

    unless raw.nil?
      parsed = JSON.parse(raw)
      parsed['name']
    end
  end
end
