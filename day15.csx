#!/usr/bin/env dotnet-script
using System;  
using System.IO;
class Main
{

    int Solve(int n, int limit, int[] nums, Dictionary<int, int> mp) {
        
        int n_tmp = 0,
        cnt = nums.Length;

        while (cnt < limit - 1) {
            cnt += 1;
            if (!mp.ContainsKey(n))
            {
                mp[n] = cnt;
                n = 0;
            } 
            else 
            {
                n_tmp = cnt - mp[n];
                mp[n] = cnt;
                n = n_tmp;
            }
        }
        return n;
    }

    public Main()
    {
        string fl = File.ReadAllText("inputs/inp_day15.txt");
        int[] data = Array.ConvertAll(fl.Split(","), s => int.Parse(s));

        Dictionary<int, int> mp = new Dictionary<int, int>();

        for (int i = 0; i < data.Length; i++)
        {
            mp[data[i]] = i + 1;
        }

        Console.WriteLine(Solve(data[data.Length-1], 30000000, data.SkipLast(1).ToArray(), mp));
    }
}

Main m = new Main();