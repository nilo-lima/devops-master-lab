import argparse
import hashlib
import json
import sys
from pathlib import Path

HASH_STORE_DEFAULT = "config/hashes.json"


def calculate_hash(filepath: Path) -> str:
    sha256 = hashlib.sha256()
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            sha256.update(chunk)
    return sha256.hexdigest()


def load_store(store_path: Path) -> dict:
    if not store_path.exists():
        return {}
    return json.loads(store_path.read_text())


def save_store(hashes: dict, store_path: Path) -> None:
    store_path.parent.mkdir(parents=True, exist_ok=True)
    store_path.write_text(json.dumps(hashes, indent=2, sort_keys=True))


def collect_files(target: Path) -> list:
    if target.is_file():
        return [target]
    return sorted(f for f in target.rglob("*") if f.is_file())


def cmd_init(target: Path, store_path: Path) -> None:
    files = collect_files(target)
    if not files:
        print(f"Nenhum arquivo encontrado em: {target}")
        sys.exit(1)

    hashes = {str(f.resolve()): calculate_hash(f) for f in files}
    save_store(hashes, store_path)
    print(f"Hashes armazenados com sucesso. {len(hashes)} arquivo(s) registrado(s).")


def cmd_check(target: Path, store_path: Path) -> None:
    stored = load_store(store_path)
    if not stored:
        print("Erro: Nenhum hash armazenado. Execute 'init' primeiro.")
        sys.exit(1)

    files = collect_files(target)
    has_issues = False

    print("\nRelatório de Verificação de Integridade:")
    print("-" * 55)

    checked_keys = set()
    for filepath in files:
        key = str(filepath.resolve())
        checked_keys.add(key)
        current_hash = calculate_hash(filepath)

        if key not in stored:
            print(f"  [NOVO]       {filepath}")
            has_issues = True
        elif stored[key] != current_hash:
            print(f"  [MODIFICADO] {filepath}")
            has_issues = True
        else:
            print(f"  [OK]         {filepath}")

    for key in stored:
        if key not in checked_keys and not Path(key).exists():
            print(f"  [DELETADO]   {key}")
            has_issues = True

    print("-" * 55)
    if has_issues:
        print("Status: ADULTERAÇÃO DETECTADA\n")
        sys.exit(1)
    else:
        print("Status: ÍNTEGRO\n")
        sys.exit(0)


def cmd_update(target: Path, store_path: Path) -> None:
    stored = load_store(store_path)
    files = collect_files(target)
    if not files:
        print(f"Nenhum arquivo encontrado em: {target}")
        sys.exit(1)

    for filepath in files:
        key = str(filepath.resolve())
        stored[key] = calculate_hash(filepath)
        print(f"Hash atualizado: {filepath}")

    save_store(stored, store_path)
    print(f"\nAtualização concluída. {len(files)} arquivo(s) atualizado(s).")


def main():
    parser = argparse.ArgumentParser(
        description="Verificador de Integridade de Arquivos de Log via SHA-256",
    )
    parser.add_argument("command", choices=["init", "check", "update"],
                        help="Comando: init | check | update")
    parser.add_argument("path", help="Arquivo ou diretório alvo")
    parser.add_argument(
        "--store",
        default=HASH_STORE_DEFAULT,
        help=f"Caminho para o banco de hashes (padrão: {HASH_STORE_DEFAULT})",
    )

    args = parser.parse_args()
    target = Path(args.path)
    store = Path(args.store)

    if not target.exists():
        print(f"Erro: Caminho não encontrado: {target}")
        sys.exit(1)

    if args.command == "init":
        cmd_init(target, store)
    elif args.command == "check":
        cmd_check(target, store)
    elif args.command == "update":
        cmd_update(target, store)


if __name__ == "__main__":
    main()
