function result = isequalMatrix(m1, m2)

        diff = m1 - m2;
        absDiff = abs(diff);
        sumDiff = sum(absDiff > 0.000001, "all");
        result = isequal(sumDiff, 0);

end