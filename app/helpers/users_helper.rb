module UsersHelper
  def convert_to_e164(raw_phone)
      Phony.format(
          raw_phone,
          :format => :international,
          :spaces => ''
      ).gsub(/\s+/, "") # Phony won't remove all spaces
  end
end
