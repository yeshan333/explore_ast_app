beam_file_path = "_build/prod/rel/explore_ast_app/lib/explore_ast_app-0.1.0/ebin/Elixir.ExploreAstApp.beam"
all_chunks = :beam_lib.all_chunks(String.to_charlist(beam_file_path))
result = :beam_lib.chunks(String.to_charlist(beam_file_path), [:abstract_code])

beam_file_path = "_build/prod/rel/explore_ast_app/lib/explore_ast_app-0.1.0/ebin/Elixir.ExploreAstApp.beam"
