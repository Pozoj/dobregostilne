# Encoding: utf-8
class String

  def make_websafe
    self.strip.gsub('d.d.', '').gsub('d.o.o.', '').gsub('"', '').gsub("'", '').strip.debalkanize.downcase.gsub(' ', '-').gsub(',', '').gsub('.', '').gsub('---', '-').gsub('--', '-').strip
  end

  def debalkanize
    self.gsub('Č', 'C').gsub('Š', 'S').gsub('Ž', 'Z').gsub('Ć', 'C').gsub('Đ', 'DZ').gsub('č', 'c').gsub('š', 's').gsub('ž', 'z').gsub('ć', 'c').gsub('đ', 'dz')
  end

  def debalkanize!
    replace self.debalkanize
  end

  def make_file_system_friendly
    self.strip.debalkanize.downcase.gsub(' ', '_')
  end
  
  def self.rand(length=6)
    Digest::SHA2.hexdigest(ActiveSupport::SecureRandom.base64(8)).slice 0, length
  end
  
end
