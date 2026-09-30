# ⚙️ IL Dead Code Eliminator

A syntax-driven compiler optimization tool implemented in **Lex** and **Yacc** that performs **Dead Code Elimination (DCE)** on C-like Intermediate Language (IL) assignment statements. It dynamically tracks variable liveness using backward data-flow analysis to ensure only essential computations and variables are preserved.

---

## ✨ Key Features

* **Toolchain:** Built using standard compiler construction tools: **Lex** (Lexical Analyzer) and **Yacc** (LALR Parser Generator).
* **Optimization Logic:** Implements backward data-flow analysis to identify and eliminate dead variable assignments that do not affect the program's final live state.
* **Three-Phase Pipeline:** Robust execution model featuring code reversal, liveness set tracking, and final sequential restoration.

---

## 🧠 The Dead Code Elimination Algorithm

The tool processes the input Intermediate Language through three distinct stages:

1. **Reverse the Code:** The input IL stream is processed in reverse order to enable backward dependency analysis starting from the final outputs.
2. **Apply Liveness Analysis:**
   * Initializes a `LiveSet` containing the target variables declared as active at the program's exit.
   * Traverses each assignment statement backwards:
     * If the destination variable is not in `LiveSet`, the statement is marked as dead and pruned.
     * If active, the destination variable is removed from `LiveSet`, and its operand variables are added to track upstream dependencies.
3. **Restore & Output:** The preserved instructions are reversed back to their original flow, generating minimal and fully optimized IL code.

---

## 📝 Language Specification

Supports a C-like Intermediate Language syntax:
* **Assignments:** Three-address-like statements with up to two operands (e.g., `$a = b + c$`).
* **Operands:** Signed integer constants and alphanumeric variables.
* **Liveness Declaration:** The final line defines the preserved variable set (e.g., `{r, s}`).

---

## 🚀 How to Build & Run

### Prerequisites
Make sure you have `flex`, `bison` (or `lex`, `yacc`), and `gcc` installed:
```bash
sudo apt-get install flex bison gcc
