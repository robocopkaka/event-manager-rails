module Api::V1
  class DocsController < ApplicationController
    include Api::V1::Concerns::Docs::DocsController
  end
end