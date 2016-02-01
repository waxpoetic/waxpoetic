module ResourceGeneratorRefinement
  refine Rails::Generators::ResourceGenerator do
    def generate_policy
      generate :policy, file_name
    end
  end
end
