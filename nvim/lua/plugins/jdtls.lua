return {
    "mfussenegger/nvim-jdtls",
    opts = {
        settings = {
            java = {
                inlayHints = {
                    parameterNames = {
                        enabled = "all",
                    },
                },
                format = {
                    enabled = true,
                    settings = {
                        url = "/Users/petterberven/GoogleStyle.xml",
                        profile = "GoogleStyle",
                    },
                },
            },
        },
    },
}
