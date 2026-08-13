## Hashname
`translation_overlay`

## Entry hashname
`journal`, `catalogue`, `newspaper`, `generic`, or `minigame`

## Tree structure
Entry point `journal`:
```bash
└── Journal : Container
    ├── textField<0-15> : Container
    │   ├── text : String
    │   └── style : Int (0-6, see below)
    └── divider<0-14> : Container
        └── isVisible : Bool
```

Entry points `catalogue`:
```bash
└── Translate : Container
    └── Catalogue : Container
        ├── divider<0-24> : Container
        │   └── isVisible : Bool
        └── textField<0-24> : Container
            ├── text : String
            └── style : Int (0-6, see below)
```

Entry point `newspaper`:
```bash
└── Newspaper : Container
    ├── ArticleHeading : Container
    │   ├── text : String
    │   ├── style : Int (0-6, see below)
    │   └── isVisible : Bool
    ├── ArticleSubHeading<1-4> : Container
    │   ├── text : String
    │   ├── style : Int (0-6, see below)
    │   └── isVisible : Bool
    └── ArticleBody<1-10> : Container
        ├── text : String
        ├── style : Int (0-6, see below)
        └── isVisible : Bool
```

Entry points `generic`:
```bash
└── Translate : Container
    └── Generic : Container
        ├── textField<0-23> : Container
        │   ├── text : String
        │   └── style : Int (0-6, see below)
        └── textField<0-23>Strike : Container
            ├── text : String
            └── style : Int (0-6, see below)
```

## Style values
- 0: HEADER
- 1: SUB_HEADER
- 2: BODY_LEFT
- 3: BODY_CENTER
- 4: BODY_JUSTIFY
- 5: BODY_LEFT_AUTO_LENGTH
- 6: BODY_CENTER_AUTO_LENGTH
