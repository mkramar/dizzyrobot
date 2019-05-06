#pragma once

class QuadrantDetector
{
	int m_numQuadrants;
	int m_quadrantDiv;
	int m_q1 = -1;
	int m_q2 = -1;
	
public:
	QuadrantDetector(int numQuadrants, int quadrantDiv);
	int detectQuadrant(int sensor);
	void prepareToReverse();
	
private:	
	bool above(int a, int b);
	bool below(int a, int b);
};