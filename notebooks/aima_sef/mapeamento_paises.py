# scripts/mapeamento_paises.py
"""
Módulo Central de Mapeamento de Países
--------------------------------------
Contém todas as regras de padronização de nomes de países:
- DICT_CUSTOM: mapeamento manual de variantes
- MAPA_ISO_PT: tradução ISO → Português de Portugal
- NOMES_CANONICOS: lista de referência
"""

# ============================================================================
# 1. DICIONÁRIO CUSTOM - Mapeamento Manual de Variantes
# ============================================================================
# Chave → variante encontrada nos dados (lowercase, sem espaços extra)
# Valor → nome canónico pretendido
# ============================================================================

DICT_CUSTOM: dict[str, str] = {
    # ── São Tomé e Príncipe ────────────────────────────────────────
    "s. tomé e príncipe":          "São Tomé e Príncipe",
    "sto. tomé e príncipe":        "São Tomé e Príncipe",
    "são tomé e principe":         "São Tomé e Príncipe",
    "s. tome e principe":          "São Tomé e Príncipe",
    "sto. tome e principe":        "São Tomé e Príncipe",
    "são tomé e príncipe":         "São Tomé e Príncipe",
    "sao tome e principe":         "São Tomé e Príncipe",

    # ── Cabo Verde ────────────────────────────────────────────────
    "cabo-verde":                  "Cabo Verde",
    "cabo verde":                  "Cabo Verde",

    # ── Guiné-Bissau ──────────────────────────────────────────────
    "guiné bissau":                "Guiné-Bissau",
    "guine-bissau":                "Guiné-Bissau",
    "guine bissau":                "Guiné-Bissau",

    # ── Guiné Equatorial ──────────────────────────────────────────
    "guiné equatorial":            "Guiné Equatorial",
    "guinea equatorial":           "Guiné Equatorial",

    # ── Timor-Leste ───────────────────────────────────────────────
    "timor leste":                 "Timor-Leste",
    "timor":                       "Timor-Leste",
    "east timor":                  "Timor-Leste",

    # ── Reino Unido ───────────────────────────────────────────────
    "grã-bretanha":                "Reino Unido",
    "grã bretanha":                "Reino Unido",
    "gra-bretanha":                "Reino Unido",
    "gran bretanha":               "Reino Unido",
    "reino unido":                 "Reino Unido",
    "uk":                          "Reino Unido",
    "gb":                          "Reino Unido",
    "british subject":             "Reino Unido",
    "reino unido (british subject)": "Reino Unido",

    # ── Estados Unidos ────────────────────────────────────────────
    "estados unidos da américa":   "Estados Unidos da América",
    "estados unidos da america":   "Estados Unidos da América",
    "estados unidos":              "Estados Unidos da América",
    "eua":                         "Estados Unidos da América",
    "usa":                         "Estados Unidos da América",
    "e.u.a.":                      "Estados Unidos da América",
    "e.u.a":                       "Estados Unidos da América",
    "us":                          "Estados Unidos da América",

    # ── Países Baixos ─────────────────────────────────────────────
    "holanda":                     "Países Baixos",
    "holland":                     "Países Baixos",
    "netherlands":                 "Países Baixos",
    "países baixos":               "Países Baixos",

    # ── República Checa ───────────────────────────────────────────
    "república checa":             "República Checa",
    "chequia":                     "República Checa",
    "czech republic":              "República Checa",
    "czechia":                     "República Checa",

    # ── Coreia do Sul / Norte ─────────────────────────────────────
    "coreia do sul":               "Coreia do Sul",
    "coreia do norte":             "Coreia do Norte",
    "south korea":                 "Coreia do Sul",
    "north korea":                 "Coreia do Norte",

    # ── África do Sul ────────────────────────────────────────────
    "africa do sul":               "África do Sul",
    "áfrica do sul":               "África do Sul",
    "south africa":                "África do Sul",

    # ── Outros ───────────────────────────────────────────────────
    "russia":                      "Rússia",
    "rússia":                      "Rússia",
    "turquia":                     "Turquia",
    "turkey":                      "Turquia",
    "côte d'ivoire":               "Costa do Marfim",
    "costa do marfim":             "Costa do Marfim",
    "ivory coast":                 "Costa do Marfim",
    "myanmar":                     "Mianmar",
    "myanmar (birmânia)":          "Mianmar",
    "burma":                       "Mianmar",
    
    # ── Ilhas ────────────────────────────────────────────────────
    "fidji (ilhas)":               "Ilhas Fiji",
    "ilhas fidji":                 "Ilhas Fiji",
    "fiji":                        "Ilhas Fiji",
    "maurícias (ilhas)":           "Ilhas Maurícias",
    "mauricias (ilhas)":           "Ilhas Maurícias",
    "maurícia":                    "Ilhas Maurícias",
    "mauritius":                   "Ilhas Maurícias",

    # ── Outras variantes ─────────────────────────────────────────
    "macedónia":                   "Macedónia do Norte",
    "macedonia":                   "Macedónia do Norte",
    "suazilândia":                 "Essuatíni",
    "suazilandia":                 "Essuatíni",
    "swaziland":                   "Essuatíni",
    "eswatini":                    "Essuatíni",
    
    # ── Variantes adicionais encontradas nos dados ─────────────────
    "cambodja":                        "Camboja",
    "estados unidos américa":          "Estados Unidos da América",
    "barém":                           "Bahrein",
    "benim":                           "Benin",
    "grã-bretanha (british subject)":  "Reino Unido",
    "guiné conacri":                   "Guiné",
    "jibuti":                          "Djibuti",
    "quatar":                          "Qatar",
    "república centro africana":       "República Centro-Africana",
    "república da coreia":             "Coreia do Sul",
    "república do sudão":              "Sudão",
    "república eslovaca":              "Eslováquia",
    "são vicente e grenadinas":        "São Vicente e Granadinas",
    "união das comores":               "Comores",
    "usbequistão":                     "Uzbequistão",

    # ── Países extintos (dados históricos, mantidos como categoria própria) ──
    "checoslováquia":                  "Checoslováquia",
    "jugoslávia":                      "Jugoslávia",
    "urss":                            "URSS",
}

# ============================================================================
# 2. MAPA ISO → PORTUGUÊS DE PORTUGAL
# ============================================================================
# ISO 3166-1 alpha-2 → Nome em Português de Portugal
# ============================================================================

MAPA_ISO_PT: dict[str, str] = {
    "AF": "Afeganistão", "ZA": "África do Sul", "AL": "Albânia", 
    "DE": "Alemanha", "AD": "Andorra", "AO": "Angola", 
    "AI": "Anguila", "AQ": "Antártida", "AG": "Antígua e Barbuda", 
    "SA": "Arábia Saudita", "DZ": "Argélia", "AR": "Argentina", 
    "AM": "Arménia", "AW": "Aruba", "AU": "Austrália", 
    "AT": "Áustria", "AZ": "Azerbaijão", "BS": "Bahamas", 
    "BD": "Bangladesh", "BB": "Barbados", "BH": "Bahrein", 
    "BE": "Bélgica", "BZ": "Belize", "BJ": "Benin", 
    "BM": "Bermudas", "BY": "Bielorrússia", "BO": "Bolívia", 
    "BQ": "Países Baixos Caribenhos", "BA": "Bósnia e Herzegovina", 
    "BW": "Botswana", "BR": "Brasil", "BN": "Brunei", 
    "BG": "Bulgária", "BF": "Burkina Faso", "BI": "Burundi", 
    "BT": "Butão", "CV": "Cabo Verde", "KH": "Camboja", 
    "CM": "Camarões", "CA": "Canadá", "QA": "Qatar", 
    "KZ": "Cazaquistão", "TD": "Chade", "CZ": "República Checa", 
    "CL": "Chile", "CN": "China", "CY": "Chipre", 
    "CX": "Ilha do Natal", "CC": "Ilhas Cocos", 
    "CO": "Colômbia", "KM": "Comores", "CG": "Congo", 
    "CD": "República Democrática do Congo", "CK": "Ilhas Cook", 
    "KP": "Coreia do Norte", "KR": "Coreia do Sul", 
    "CI": "Costa do Marfim", "CR": "Costa Rica", "HR": "Croácia", 
    "CU": "Cuba", "CW": "Curaçau", "DK": "Dinamarca", 
    "DM": "Dominica", "DO": "República Dominicana", 
    "DJ": "Djibuti", "EG": "Egipto", "SV": "El Salvador", 
    "AE": "Emiratos Árabes Unidos", "ER": "Eritreia", 
    "EE": "Estónia", "SZ": "Essuatíni", "ET": "Etiópia", 
    "FK": "Ilhas Malvinas", "FO": "Ilhas Faroé", "FJ": "Ilhas Fiji", 
    "PH": "Filipinas", "FI": "Finlândia", "FR": "França", 
    "GF": "Guiana Francesa", "PF": "Polinésia Francesa", 
    "TF": "Terras Austrais Francesas", "GA": "Gabão", 
    "GM": "Gâmbia", "GE": "Geórgia", "GH": "Gana", 
    "GI": "Gibraltar", "GR": "Grécia", "GL": "Gronelândia", 
    "GD": "Granada", "GP": "Guadalupe", "GU": "Guam", 
    "GT": "Guatemala", "GG": "Guernsey", "GN": "Guiné", 
    "GW": "Guiné-Bissau", "GQ": "Guiné Equatorial", "GY": "Guiana", 
    "HT": "Haiti", "HN": "Honduras", "HK": "Hong Kong", 
    "HU": "Hungria", "YE": "Iémen", "IM": "Ilha de Man", 
    "IN": "Índia", "ID": "Indonésia", "IR": "Irão", 
    "IQ": "Iraque", "IE": "Irlanda", "IS": "Islândia", 
    "IL": "Israel", "IT": "Itália", "JM": "Jamaica", 
    "JP": "Japão", "JE": "Jersey", "JO": "Jordânia", 
    "XK": "Kosovo", "KW": "Kuwait", "KG": "Quirguistão", 
    "LA": "Laos", "LV": "Letónia", "KE": "Quénia", 
    "KI": "Kiribati", "LB": "Líbano", "LS": "Lesoto", 
    "LR": "Libéria", "LY": "Líbia", "LI": "Liechtenstein", 
    "LT": "Lituânia", "LU": "Luxemburgo", "MO": "Macau", 
    "MK": "Macedónia do Norte", "MG": "Madagáscar", 
    "MW": "Maláui", "MY": "Malásia", "MV": "Maldivas", 
    "ML": "Mali", "MT": "Malta", "MH": "Ilhas Marshall", 
    "MQ": "Martinica", "MR": "Mauritânia", "MU": "Ilhas Maurícias", 
    "YT": "Mayotte", "MX": "México", "FM": "Micronésia", 
    "MD": "Moldávia", "MC": "Mónaco", "MN": "Mongólia", 
    "ME": "Montenegro", "MS": "Montserrat", "MA": "Marrocos", 
    "MZ": "Moçambique", "NA": "Namíbia", "NR": "Nauru", 
    "NP": "Nepal", "NL": "Países Baixos", "NC": "Nova Caledónia", 
    "NZ": "Nova Zelândia", "NI": "Nicarágua", "NE": "Níger", 
    "NG": "Nigéria", "NU": "Niue", "NF": "Ilha Norfolk", 
    "MP": "Ilhas Marianas do Norte", "NO": "Noruega", 
    "OM": "Omã", "PK": "Paquistão", "PW": "Palau", 
    "PS": "Palestina", "PA": "Panamá", "PG": "Papua-Nova Guiné", 
    "PY": "Paraguai", "PE": "Peru", "PN": "Ilhas Pitcairn", 
    "PL": "Polónia", "PT": "Portugal", "PR": "Porto Rico", 
    "RE": "Reunião", "RO": "Roménia", "RU": "Rússia", 
    "RW": "Ruanda", "BL": "São Bartolomeu", "SH": "Santa Helena", 
    "KN": "São Cristóvão e Nevis", "LC": "Santa Lúcia", 
    "MF": "São Martinho", "PM": "São Pedro e Miquelão", 
    "VC": "São Vicente e Granadinas", "WS": "Samoa", 
    "SM": "San Marino", "ST": "São Tomé e Príncipe", 
    "SN": "Senegal", "RS": "Sérvia", "SC": "Seychelles", 
    "SL": "Serra Leoa", "SG": "Singapura", "SX": "Sint Maarten", 
    "SK": "Eslováquia", "SI": "Eslovénia", "SB": "Ilhas Salomão", 
    "SO": "Somália", "ES": "Espanha", "LK": "Sri Lanka", 
    "SD": "Sudão", "SS": "Sudão do Sul", "SR": "Suriname", 
    "SJ": "Svalbard e Jan Mayen", "SE": "Suécia", "CH": "Suíça", 
    "SY": "Síria", "TW": "Taiwan", "TJ": "Tajiquistão", 
    "TZ": "Tanzânia", "TH": "Tailândia", "TL": "Timor-Leste", 
    "TG": "Togo", "TK": "Tokelau", "TO": "Tonga", 
    "TT": "Trindade e Tobago", "TN": "Tunísia", "TR": "Turquia", 
    "TM": "Turquemenistão", "TC": "Ilhas Turcas e Caicos", 
    "TV": "Tuvalu", "UG": "Uganda", "UA": "Ucrânia", 
    "GB": "Reino Unido", "US": "Estados Unidos da América", 
    "UY": "Uruguai", "UZ": "Uzbequistão", "VU": "Vanuatu", 
    "VA": "Vaticano", "VE": "Venezuela", "VN": "Vietname", 
    "VG": "Ilhas Virgens Britânicas", "VI": "Ilhas Virgens Americanas", 
    "WF": "Wallis e Futuna", "EH": "Sara Ocidental", 
    "ZM": "Zâmbia", "ZW": "Zimbabwe", 
    "AS": "Samoa Americana", "AX": "Ilhas Åland", 
    "BV": "Ilha Bouvet", "GS": "Geórgia do Sul e Ilhas Sandwich do Sul", 
    "HM": "Ilhas Heard e McDonald", 
    "IO": "Território Britânico do Oceano Índico", 
    "KY": "Ilhas Caimão", "UM": "Ilhas Menores Distantes dos EUA",
    "CF": "República Centro-Africana",
    "EC": "Equador",
}

# ============================================================================
# 3. ÍNDICES AUXILIARES
# ============================================================================

# Nomes canônicos em português (para fuzzy matching)
NOMES_CANONICOS_PT: set[str] = (
    set(MAPA_ISO_PT.values()) 
    | set(DICT_CUSTOM.values()) 
    | {"Apátrida", "Desconhecido", "Não determinado", "Outro"}
)

# Índice para lookup O(1) (lowercase → canônico)
INDICE_CANONICO: dict[str, str] = {nome.lower(): nome for nome in NOMES_CANONICOS_PT}

# ============================================================================
# 4. FUNÇÃO PARA VALIDAÇÃO
# ============================================================================

def validar_mapeamentos():
    """
    Função de diagnóstico: verifica integridade dos mapeamentos
    """
    print("🔍 Validando mapeamentos de países...")
    print(f"   DICT_CUSTOM: {len(DICT_CUSTOM)} entradas")
    print(f"   MAPA_ISO_PT: {len(MAPA_ISO_PT)} entradas")
    print(f"   NOMES_CANONICOS: {len(NOMES_CANONICOS_PT)} nomes únicos")
    
    # Verifica duplicados no DICT_CUSTOM
    valores_custom = list(DICT_CUSTOM.values())
    duplicados = [v for v in set(valores_custom) if valores_custom.count(v) > 1]
    if duplicados:
        print(f"   ⚠️ Valores duplicados no DICT_CUSTOM: {duplicados}")
    
    # Verifica se há chaves duplicadas no MAPA_ISO_PT
    if len(MAPA_ISO_PT) != len(set(MAPA_ISO_PT.keys())):
        print("   ⚠️ Códigos ISO duplicados no MAPA_ISO_PT")
    
    print("✅ Validação concluída")
    return True

# ============================================================================
# 5. EXPORTAÇÃO EXPLÍCITA (para importações claras)
# ============================================================================

__all__ = [
    'DICT_CUSTOM',
    'MAPA_ISO_PT',
    'NOMES_CANONICOS_PT',
    'INDICE_CANONICO',
    'validar_mapeamentos',
]