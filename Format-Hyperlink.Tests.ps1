Describe "Format-Hyperlink" {
    BeforeAll {
        Import-Module .\Format-Hyperlink.psm1
    }

    It "Given no parameters, it returns an empty string" {
        $output = Format-Hyperlink
        $output | Should -Be ""
    }

    Context "Uri via pipeline" {
        It "Given Uri '<Uri>', Label '<Label>', it returns '<Expected>'" -TestCases @(
            @{Uri = ''; Label = ''; Expected = ''},
            @{Uri = ''; Label = 'Example'; Expected = 'Example'},
            @{Uri = 'https://example.com'; Label = ''; Expected = 'https://example.com/'},
            @{Uri = 'https://example.com'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
            @{Uri = 'https://example.com/'; Label = ''; Expected = 'https://example.com/'},
            @{Uri = 'https://example.com/'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
            @{Uri = 'https://example.com/example'; Label = ''; Expected = 'https://example.com/example'},
            @{Uri = 'https://example.com/example'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/example$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
        ) {
            param ($Uri, $Label, $Expected)

            $output = $($Uri | Format-Hyperlink -Label $Label)
            $output | Should -Be $Expected
        }
    }

    Context "Uri via flag" {
        It "Given Uri '<Uri>', Label '<Label>', it returns '<Expected>'" -TestCases @(
            @{Uri = ''; Label = ''; Expected = ''},
            @{Uri = ''; Label = 'Example'; Expected = 'Example'},
            @{Uri = 'https://example.com'; Label = ''; Expected = 'https://example.com/'},
            @{Uri = 'https://example.com'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
            @{Uri = 'https://example.com/'; Label = ''; Expected = 'https://example.com/'},
            @{Uri = 'https://example.com/'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
            @{Uri = 'https://example.com/example'; Label = ''; Expected = 'https://example.com/example'},
            @{Uri = 'https://example.com/example'; Label = 'Example'; Expected = "$([char]0x1b)]8;;https://example.com/example$([char]0x1b)\Example$([char]0x1b)]8;;$([char]0x1b)\"}
        ) {
            param ($Uri, $Label, $Expected)

            $output = Format-Hyperlink -Uri $Uri -Label $Label
            $output | Should -Be $Expected
        }
    }
}