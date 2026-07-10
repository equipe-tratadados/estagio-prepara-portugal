# scripts/limpeza/mapeamento.py
"""
Módulo Central de Mapeamento e Padronização de Colunas
--------------------------------------
Este ficheiro é a 'fonte da verdade' para a tradução e padronização de colunas
de formato RAW (fontes variadas) para o formato CSV padrão (padrão do projeto).

Regra: Origem (PT/Vários formatos) -> Destino (snake_case em Inglês)
"""

# 1. PORDATA
PORDATA_MAPPING = {
    "Anos": "year",
    "Ano": "year",
    "País": "country",
    "Países": "country",
    "Total de estrangeiros": "resident_foreign_population",
    "Taxa bruta de imigração": "immigration_rate",  # Usando a versão curta sugerida
}

# 2. INE (Instituto Nacional de Estatística)
INE_MAPPING = {
    "Ano de referência": "year",
    "País de nacionalidade": "country",
    "País de nascimento": "country_of_birth",
    "População residente (N.º)": "resident_count",
    "Produto interno bruto (PIB)": "gdp",
    "Nível de escolaridade completo": "education_level",
}

# 3. AIMA / SEF
AIMA_MAPPING = {
    "Período": "year",
    "Nacionalidade": "nationality",
    "Motivo de concessão": "application_reason",
    "Tipo de documento / visto": "permit_type",
    "Tipo de autorização": "permit_type",
    "Pedidos de asilo": "asylum_applications",
    "Aquisição de nacionalidade": "naturalization_count",
    "Recusas de entrada": "entry_refusals",
    "Afastamentos": "deportations",
    "Total": "resident_count",
}

# 4. Termos Geográficos e Administrativos Comuns
GEOGRAPHY_MAPPING = {
    "Concelho": "municipality",
    "Distrito": "district",
    "Região": "region",
    "Região Autónoma": "region",
    "Divisão Administrativa": "region",  # Usando a alternativa curta para divisões mistas
    "Continente": "continent",
}

# 5. Dados Económicos, Trabalho e Segurança Social
ECONOMY_MAPPING = {
    "Setor de atividade": "economic_sector",
    "Estatuto profissional": "employment_status",
    "Valor de contribuições": "social_security_contributions",
    "N.º de contribuintes": "social_security_contributors",
    "Beneficiários": "social_security_beneficiaries",

    "Ano de chegada": "arrival_year",
    "País de residência anterior": "previous_country_of_residence",
    "Reagrupamento familiar": "family_reunification",
    "Estatuto de refugiado": "refugee_status"
}

# 6. Dados de Migração — Fluxos Migratórios e Demografia
#
# Equivalências entre fontes:
#   SEF "Stock" ←→ AIMA "População Residente"   → total acumulado com título válido (a 31-dez)
#   SEF "Fluxo" ←→ AIMA "Concessão de Títulos"  → novos títulos emitidos no ano civil
#
# Nota AIMA (2023-2024): "Concessão de Títulos" pode incluir decisões sobre processos
# pendentes de anos anteriores (ex-Manifestações de Interesse), pelo que não equivale
# necessariamente a entradas físicas nesse ano.

MIGRATION_MAPPING = {

    # ── Termos Gerais e Demográficos ─────────────────────────────────────────
    "Masculino":                        "male",
    "Feminino":                         "female",
    "Género":                           "gender",
    "Sexo":                             "gender",
    "Estado civil":                     "marital_status",

    # ── STOCK / POPULAÇÃO RESIDENTE ──────────────────────────────────────────
    # Total acumulado de cidadãos estrangeiros com título válido.
    # SEF usa "Stock"; AIMA usa "População Residente". Mesmo indicador.
    "Stock":                            "resident_count",
    "Stock_Homens":                     "resident_count_male",
    "Stock_Mulheres":                   "resident_count_female",
    "Pop_Residente":                    "resident_count",          # alias AIMA
    "Pop_Residente_Masculino":          "resident_count_male",     # alias AIMA
    "Pop_Residente_Feminino":           "resident_count_female",   # alias AIMA

    # ── FLUXO / CONCESSÃO DE TÍTULOS ─────────────────────────────────────────
    # Novos títulos de residência emitidos no ano civil.
    # SEF usa "Fluxo"; AIMA usa "Concessão de Títulos". Mesmo indicador.
    "Fluxo":                            "permits_granted",
    "Fluxos_Homens":                    "permits_granted_male",
    "Fluxos_Mulheres":                  "permits_granted_female",
    "Concessao":                        "permits_granted",         # alias AIMA
    "Concessao_Masculino":              "permits_granted_male",    # alias AIMA
    "Concessao_Feminino":               "permits_granted_female",  # alias AIMA

    # ── Metadados Administrativos ─────────────────────────────────────────────
    "Ano de chegada":                   "arrival_year",
    "País de residência anterior":      "previous_country_of_residence",
    "Reagrupamento familiar":           "family_reunification",
    "Estatuto de refugiado":            "refugee_status",
}
    
# ==============================================================================
# DICIONÁRIO MASTER UNIFICADO
# ==============================================================================
# Combina todos os dicionários acima. O Pandas usará este mapa global.
MAPA_GLOBAL_COLUNAS = {
    **PORDATA_MAPPING,
    **INE_MAPPING,
    **AIMA_MAPPING,
    **GEOGRAPHY_MAPPING,
    **ECONOMY_MAPPING,
    **MIGRATION_MAPPING
}

def padronizar_colunas(df):
    """
    Função utilitária para aplicar o mapeamento a um DataFrame do Pandas.
    Também remove espaços em branco extras nas colunas antes de traduzir.
    """
    # Remove espaços em branco nas pontas dos nomes das colunas originais
    df.columns = [str(col).strip() for col in df.columns]
    
    # Aplica o mapeamento global
    df_renomeado = df.rename(columns=MAPA_GLOBAL_COLUNAS)
    
    # Deteta se ficaram colunas com acentos (potencialmente não traduzidas)
    acentos = "áéíóúçãõÀÉÓ"
    nao_traduzidas = [c for c in df_renomeado.columns if any(char in acentos for char in str(c))]
    
    if nao_traduzidas:
        print(f"\n⚠️ [AVISO MAPEAMENTO]: Estas colunas mantêm-se em PT: {nao_traduzidas}")
        print("Verifique se precisam de ser adicionadas ao ficheiro 'mapeamento.py'.\n")
        
    return df_renomeado