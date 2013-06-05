module UcbRails::LdapPerson
  class TestFinder
    PersonNotFound = Class.new(StandardError)

    def find_by_uid(uid)
      find_by_attributes(:uid => uid.to_s).first
    end

    def find_by_uid!(uid)
      find_by_uid(uid) || raise(PersonNotFound, "uid=#{uid.inspect}")
    end

    def find_by_first_last(first_name, last_name)
      find_by_attributes(:first_name => first_name, :last_name => last_name)
    end

    def find_by_attributes(attributes)
      self.class.entries.select { |entry| entry_matches_attributes(entry, attributes) }
    end

    def entry_matches_attributes(entry, attributes)
      attributes.keys.all? do |key|
        value = attributes[key].to_s.downcase
        value.blank? || entry.send(key).downcase.include?(value)
      end
    end

    def self.entries
      [
        new_entry("1", 'art', "Art", "Andrews", "art@example.com", "999-999-0001", "Dept 1"),
        new_entry("2", 'beth', "Beth", "Brown", "beth@example.com", "999-999-0002", "Dept 2"),
        new_entry("61065", 'runner', "Steven", "Hansen", "runner@berkeley.edu", "999-999-9998", "EAS"),
        new_entry("191501", 'stevedowney', "Steve", "Downey", "sldowney@berkeley.edu", "999-999-9999", "EAS"),
      ]
    end

    def self.new_entry(uid, calnet_id, fn, ln, email, phone, depts)
      LdapPerson::Entry.new(
        :uid => uid,
        :calnet_id => calnet_id,
        :first_name => fn,
        :last_name => ln,
        :email => email,
        :phone => phone,
        :departments => depts
      )
    end
    
  end
end