return {
    -- Specify the plugin name or repository URL
    'terrortylor/nvim-comment',

    -- Define the configuration for the plugin
    config = function()
        -- Call the setup function of the plugin and pass any configuration options
        require("nvim_comment").setup {
            -- Specify configuration options here
            marker_padding = true,
            comment_empty = true,
            comment_empty_trim_whitespace = true,
            create_mappings = true,
            line_mapping = "gcc",
            operator_mapping = "gc",
            comment_chunk_text_object = "ic",
            hook = nil
        }
    end
}
