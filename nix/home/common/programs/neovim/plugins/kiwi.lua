local HOME = os.getenv("HOME")

require('kiwi').setup({
        {
        name = "notes",
        path = HOME .. "/Nextcloud/Notes"
    },
})
