require 'yaml'

class ReferenceReader

	DEFAULT_YAML = "../test_db/responses.yml"

	def get_reference_map_from(file = DEFAULT_YAML)
		results = YAML.load_file(file)

		reference_map = Hash.new
		results.each do |result|
			id = result['id']
			reference = result['reference']

			reference_map.store(id, reference)
		end
		reference_map
	end
end

r = ReferenceReader.new
hash =  r.get_reference_map_from
puts hash