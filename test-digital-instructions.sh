#!/bin/bash
# QX Digital Instructions Translation Test
# Tests the DIG element implementation

echo "🧪 QX Digital Instructions Translation Test"
echo "=========================================="

PASS_COUNT=0
FAIL_COUNT=0

# Test 1: DIG symbol in symbol map
if grep -q "⚙️.*Digital Instructions" apec-symbolmap.yaml; then
    echo "✅ Test 1 PASS: DIG symbol found in symbol map"
    ((PASS_COUNT++))
else
    echo "❌ Test 1 FAIL: DIG symbol missing from symbol map"
    ((FAIL_COUNT++))
fi

# Test 2: DIG in QX manifest
if grep -q "DIG.*Digital Instructions" .qx.yaml; then
    echo "✅ Test 2 PASS: DIG element found in QX manifest"
    ((PASS_COUNT++))
else
    echo "❌ Test 2 FAIL: DIG element missing from QX manifest"
    ((FAIL_COUNT++))
fi

# Test 3: DIG in EBNF grammar
if grep -q '"DIG"' qx-ops.md; then
    echo "✅ Test 3 PASS: DIG included in EBNF grammar"
    ((PASS_COUNT++))
else
    echo "❌ Test 3 FAIL: DIG missing from EBNF grammar"
    ((FAIL_COUNT++))
fi

# Test 4: DIG in wire format
if grep -q "G.*DIG" qx-store.spec.md; then
    echo "✅ Test 4 PASS: DIG type included in wire format"
    ((PASS_COUNT++))
else
    echo "❌ Test 4 FAIL: DIG type missing from wire format"
    ((FAIL_COUNT++))
fi

# Test 5: Digital instructions documentation exists
if [ -f "qx-digital-instructions.md" ]; then
    echo "✅ Test 5 PASS: Digital instructions documentation exists"
    ((PASS_COUNT++))
else
    echo "❌ Test 5 FAIL: Digital instructions documentation missing"
    ((FAIL_COUNT++))
fi

# Test 6: Example DOT with DIG exists
if [ -f "example-digital-instructions.yaml" ] && grep -q "DIG:DEPLOY-COMMANDS" example-digital-instructions.yaml; then
    echo "✅ Test 6 PASS: Example DOT with DIG instructions exists"
    ((PASS_COUNT++))
else
    echo "❌ Test 6 FAIL: Example DOT with DIG missing"
    ((FAIL_COUNT++))
fi

# Test 7: README mentions digital instructions
if grep -q "Digital Instructions" README.md; then
    echo "✅ Test 7 PASS: README mentions digital instructions"
    ((PASS_COUNT++))
else
    echo "❌ Test 7 FAIL: README doesn't mention digital instructions"
    ((FAIL_COUNT++))
fi

# Test 8: ASCII fallback for DIG exists
if grep -q "DIG.*\[DIG\]" apec-fallbacks.yaml; then
    echo "✅ Test 8 PASS: ASCII fallback for DIG exists"
    ((PASS_COUNT++))
else
    echo "❌ Test 8 FAIL: ASCII fallback for DIG missing"
    ((FAIL_COUNT++))
fi

# Test 9: Detection heuristics include DIG
if grep -q "DIG:" .userintent.now.yaml; then
    echo "✅ Test 9 PASS: Detection heuristics include DIG"
    ((PASS_COUNT++))
else
    echo "❌ Test 9 FAIL: Detection heuristics missing DIG"
    ((FAIL_COUNT++))
fi

# Test 10: DOT template includes DIG
if grep -q "DIG.*Digital Instructions" dot.yaml; then
    echo "✅ Test 10 PASS: DOT template includes DIG"
    ((PASS_COUNT++))
else
    echo "❌ Test 10 FAIL: DOT template missing DIG"
    ((FAIL_COUNT++))
fi

echo ""
echo "=========================================="
echo "📊 Test Results Summary:"
echo "✅ Passed: $PASS_COUNT"
echo "❌ Failed: $FAIL_COUNT"
echo "📈 Total:  $((PASS_COUNT + FAIL_COUNT))"

if [ $FAIL_COUNT -eq 0 ]; then
    echo "🎉 All tests passed! Digital instructions translation is properly implemented."
    exit 0
else
    echo "⚠️  Some tests failed. Please review the implementation."
    exit 1
fi