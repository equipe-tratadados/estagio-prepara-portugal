from pathlib import Path
import pandas as pd

# Define a pasta raiz a partir de onde o script vai procurar ('.' = diretório atual)
#ROOT_DIR = Path("../data/2-clean/")

SCRIPT_DIR = Path(__file__).resolve().parent  # Encontra a pasta 'scripts/validacao'
ROOT_DIR = SCRIPT_DIR.parent.parent / "data" / "3-delivery" / "seg_social"  # Sobe 2 níveis e entra em data/2-clean/seg_social

def ver_amostra_csvs(pasta_raiz):
    # Procura todos os ficheiros .csv em todas as subpastas (recursivo)
    ficheiros_csv = sorted(pasta_raiz.rglob("*.csv"))
    
    if not ficheiros_csv:
        print("⚠️ Nenhum ficheiro .csv encontrado no repositório.")
        return

    print(f"🔍 Encontrados {len(ficheiros_csv)} ficheiros .csv no repositório:\n")

    for ficheiro in ficheiros_csv:
        print("=" * 80)
        print(f"📁 Ficheiro: {ficheiro}")
        print("=" * 80)
        
        try:
            # Tenta ler com o padrão definido no projeto (separador ';' e UTF-8)
            df = pd.read_csv(ficheiro, sep=";", encoding="utf-8", nrows=5)
            print(df)
        except Exception:
            # Caso algum ficheiro antigo/externo ainda use vírgula
            try:
                df = pd.read_csv(ficheiro, sep=",", encoding="utf-8", nrows=5)
                print("⚠️ Nota: Lido com separador ',' em vez de ';'")
                print(df)
            except Exception as e:
                print(f"❌ Erro ao ler {ficheiro.name}: {e}")
        
        print("\n" + "-" * 80 + "\n")

if __name__ == "__main__":
    ver_amostra_csvs(ROOT_DIR)