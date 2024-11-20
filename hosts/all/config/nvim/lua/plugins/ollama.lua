vsplit = require("ollama.actions.factory").create_action({ display = true, window = "vsplit" })

require("ollama").setup({
    model = "mistral",
    url = "http://127.0.0.1:11434",
    serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
    },
    -- View the actual default prompts in ./lua/ollama/prompts.lua
    prompts = {
        Summarize = {
            prompt = "Summarize the following text:\n$sel",
            action = "display",
        },
        Ask = {
            prompt = "Regarding the following text, $input:\n$sel",
            action = "display",
        },
        Make_Table = {
            prompt = "Render the following text as markdown table:\n$sel",
            action = "insert",
            extract = false,
        },
        Enhance_Grammar_Spelling = {
            prompt =
            "Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$sel",
            action = "replace",
            extract = false,
        },
        Enhance_Wording = {
            prompt =
            "Modify the following text to use better wording, just output the final text without additional quotes around it:\n$sel",
            action = "replace",
            extract = false,
        },
        Make_Concise = {
            prompt =
            "Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$sel",
            action = "replace",
            extract = false,
        },
        Make_List = {
            prompt = "Render the following text as a markdown list:\n$sel",
            action = "replace",
            extract = false,
        },
        Generate_Tests = {
            prompt = "Generate tests for this code:\n```$ftype\n$sel\n```",
            action = vsplit
        },
    }
})
