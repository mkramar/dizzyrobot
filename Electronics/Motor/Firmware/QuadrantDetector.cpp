#include <main.h>
#include <QuadrantDetector.h>

QuadrantDetector::QuadrantDetector(int numQuadrants, int quadrantDiv)
{
	m_numQuadrants = numQuadrants;
	m_quadrantDiv = quadrantDiv;
		
	m_q1 = -1;
	m_q2 = -1;		
}
	
bool QuadrantDetector::above(int a, int b) {
	if (a > b) return true;
	if (a == 0 && b == m_numQuadrants - 1) return true;
	return false;
}
bool QuadrantDetector::below(int a, int b) {
	return above(b, a);
}
	
int QuadrantDetector::detectQuadrant(int sensor) {
	int q = sensor / m_quadrantDiv;
	bool ready = m_q1 != -1 && m_q2 != -1;
	bool good = false;
	
	if (q == m_numQuadrants) return -1;
	
	if (q != m_q1)
	{
		if (q != m_q2)
		{
			if (m_q2 == -1 || (above(q, m_q1) && above(m_q1, m_q2)) || (below(q, m_q1) && below(m_q1, m_q2)))
			{
				m_q2 = m_q1;
				m_q1 = q;
				good = true;
			}
		}
	}
	
	if (good && ready) return m_q1;
	else return -1;
}
void QuadrantDetector::prepareToReverse() {
	int nq2 = -1;
	
	if (above(m_q1, m_q2))
	{
		nq2 = (m_q1 + 1) % numExternalQuadrants;
	}
	else
	{
		nq2 = m_q1 - 1;
		if (nq2 < 0) nq2 += numExternalQuadrants;
	}
	
	m_q2 = nq2;
}	
