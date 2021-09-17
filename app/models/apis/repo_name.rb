class RepoName
  def initialize(endpoint_name)
    @endpoint_name = endpoint_name
  end

  def format
    string = @endpoint_name.split("/")[-2]
    string.split('-').map do |word|
      word.capitialize + ' '
    end.join[0..-2]
  end     
end
